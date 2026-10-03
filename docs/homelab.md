# Homelab: Bobcat

Last updated: 2026-10-03

This is the single reference for the homelab. It describes what is actually running and how it is deployed, backed up, maintained, and recovered. Anything not yet verified is listed under "Open items".

When evaluating changes, prefer the simpler option unless the added complexity has a clear benefit.

## Design principles

1. Operational simplicity over architectural purity.
2. Minimize maintenance burden.
3. Prefer single-host solutions.
4. Avoid service sprawl.
5. Keep public exposure at zero unless there is a strong reason.
6. GitHub is the authoritative source for configuration.
7. Docker Compose is the standard way to deploy services.
8. Back up configuration and application state first. Media is replaceable.

## Host

| Item | Value |
|---|---|
| Hostname | `bobcat` (only active host) |
| Hardware | Beelink EQi13 Pro, Intel Core i5-13500H, 32 GB RAM, 1 TB NVMe |
| OS | Debian 13 (trixie), headless. Fully updated on 2026-10-03 (kernel 6.12.111). |
| Admin user | `jackson` |
| LAN IP | `192.168.254.149` (static, DHCP reservation on the Google Nest Pro) |
| Gateway | `192.168.254.1` (Google Nest Pro: routing, DHCP, DNS, firewall) |
| Remote access | Tailscale (Bobcat is logged in under the user account, not tagged) |
| Public exposure | None. The Minecraft tunnel (Playit) was retired on 2026-10-02: package purged, tunnel deleted in the playit.gg dashboard. |

Services are reached by raw address and port, for example `bobcat.local:7575` for Homarr. There is no reverse proxy and no local DNS.

## Storage

| Mount | Device | Purpose |
|---|---|---|
| NVMe (root) | internal 1 TB | Debian, Docker runtime, app data in `/srv/docker/<stack>` |
| `/mnt/media` | 6 TB HDD, USB, ext4 | Media and downloads |
| `/mnt/backups` | 256 GB SSD, USB, ext4 | Restic repository at `/mnt/backups/restic` |

Both drives mount through `/etc/fstab` by `UUID=` with `defaults,nofail`, so a missing drive cannot hang boot.

```text
/mnt/media
├── movies
├── tv
├── music
└── downloads
    ├── complete
    └── incomplete
```

Application data lives in `/srv/docker/<stack>` (for example `/srv/docker/media`, `/srv/docker/homarr`). The restic apps job backs up this directory.

**Boot order:** Docker waits for the media drive. A drop-in at `/etc/systemd/system/docker.service.d/override.conf` contains `RequiresMountsFor=/mnt/media`. This prevents containers from starting against an empty `/mnt/media` folder on the NVMe and filling the root disk with downloads. The trade-off: if the media drive fails to mount, Docker (and therefore Homarr) stays down. `/mnt/backups` is deliberately not in the drop-in, because the restic scripts check for it themselves.

## Running services

All services run in Docker and are defined in the repo.

**Media stack** (`stacks/media`): Jellyfin, Sonarr, Radarr, Lidarr, Bazarr, Prowlarr, SABnzbd, Seerr. Seerr handles requests. SABnzbd is the download client and writes to `/mnt/media/downloads`.

- Jellyfin has `/dev/dri` passed through. Hardware transcoding is enabled (VAAPI/Quick Sync with Intel's `iHD` driver) and was confirmed working on 2026-10-03. The setting lives in Jellyfin under Dashboard, Playback, Transcoding.

**Dashboard** (`stacks/homarr`): Homarr.

Images are tagged `:latest`, and updates are manual. No auto-updater is installed.

## Retired services

Wound down on 2026-10-02: Minecraft (PaperMC/Geyser/Floodgate), Seafile, Vikunja, and Uptime Kuma. Containers were removed with `docker compose down`, and their stacks were moved to `stacks/_archived/` in the repo. See `stacks/_archived/README.md` for how to revive them.

- Their data directories were left in `/srv/docker/<stack>` (Seafile's was judged disposable).
- Their real `.env` files are in `stacks/_archived/<stack>/.env` on Bobcat (gitignored).
- Older restic snapshots still contain their data until they age out of retention.
- Monitoring: nothing is deployed now that Kuma is gone. Grafana, Prometheus, Loki and similar are intentionally not used.

## Repository and deployment

- Repo: `github.com/JacksonTaylor2003/Homelab`
- Clone on Bobcat: `/opt/homelab-repo`
- Layout: `stacks/media`, `stacks/homarr`, `stacks/_archived/*`, `docs/homelab.md`

**Workflow:** edit on the laptop, commit and push, then on Bobcat run `git pull` and `docker compose up -d` in the relevant stack. Bobcat never pushes.

**Secrets:** real `.env` files live next to each compose file (`stacks/<stack>/.env`) and are gitignored (`stacks/**/.env`, `*.env`, `secrets/`). Only `.env.example` files with placeholder values are tracked.

**Gotcha:** an uncommitted edit to a tracked file on Bobcat makes `git pull` abort. Run `git status --short` first. It should print nothing.

## Backups

Tool: Restic. Repository: `/mnt/backups/restic`. Password file: `/root/.config/restic/password`. Retention: 7 daily, 4 weekly, 6 monthly. Repository size is about 5 GiB, so the backup drive has plenty of headroom.

| Job | Schedule | Script | Contents |
|---|---|---|---|
| `restic-apps` | Daily 03:00 | `/usr/local/bin/restic-apps.sh` | `/srv/docker`, tag `apps` |
| `restic-system` | Sundays 04:00 | `/usr/local/bin/restic-system.sh` | `/etc`, `/opt/homelab-repo`, `/home/jackson/.ssh`, tag `system` |

How the apps job works: it checks that `/mnt/backups` is mounted, stops the `media` and `homarr` stacks (a cold backup, so databases are consistent), runs `restic backup`, applies retention with `forget --prune`, and restarts the stacks through an exit trap. The system job has the same mount check. Both scripts set `RESTIC_CACHE_DIR=/var/cache/restic`, because systemd services have no home directory and restic otherwise runs without a cache.

Excluded: media content and the download cache.

Because `.env` files sit inside `/opt/homelab-repo`, they are captured by the system job, not the apps job.

**The scripts and unit files live only on Bobcat** (`/usr/local/bin`, `/etc/systemd/system`). They are not in the repo. If you change the set of stacks, the `STACKS=(...)` line in `restic-apps.sh` must change too.

**Failure modes seen so far:**
- A snapshot can save successfully while the retention step fails. With `set -e`, the whole unit then shows as failed (exit code 11 means the repository lock could not be taken).
- A stale lock is left behind when restic is killed mid-run. Piping restic output into `head` does this. Clear it with `restic unlock` after confirming no restic process is running (`pgrep -a restic`).
- Nothing alerts on failure. Check manually (see below).

Health check:

```bash
systemctl is-failed restic-apps.service restic-system.service    # want "inactive" twice
sudo journalctl -u restic-apps.service -n 30 --no-pager
sudo RESTIC_REPOSITORY=/mnt/backups/restic RESTIC_PASSWORD_FILE=/root/.config/restic/password restic snapshots --latest 3
```

## Maintenance routine

Run this roughly monthly, and after any security advisory for Docker or the kernel.

1. Record current images: `docker images --digests > ~/images-before.txt` (the rollback reference).
2. `cd /opt/homelab-repo && git status --short && git pull`
3. Run both backup jobs and confirm they succeeded (health check above).
4. `sudo apt update`, review `apt list --upgradable`, then `sudo apt full-upgrade`. Docker, containerd and Tailscale update through their own repositories, and Docker and Tailscale restarts can drop an SSH session made over Tailscale.
5. `sudo reboot`, then confirm `findmnt /mnt/media /mnt/backups` lists both drives (run it a minute after boot) and that all nine containers are up.
6. In `stacks/media` and `stacks/homarr`: `docker compose pull && docker compose up -d`, then `docker image prune -f`.
7. Open the apps and confirm they load. Play a video in Jellyfin at a forced low quality and check the ffmpeg line in `docker logs` for `vaapi` or `qsv`.

If an app breaks after step 6, find its previous digest in `~/images-before.txt` and pin it in the compose file (commit from the laptop, pull on Bobcat).

## Recovery outline

1. Install Debian, Docker, and Tailscale. Mount the drives at `/mnt/media` and `/mnt/backups` (UUID entries in `fstab`) and add the Docker drop-in described under Storage.
2. Restore the Restic password from the password manager, then restore the latest `system` and `apps` snapshots (`restic restore latest --tag system --target /`).
3. Clone the repo to `/opt/homelab-repo` and confirm each stack's `.env` is present.
4. Run `docker compose up -d` in `stacks/media` and `stacks/homarr`.
5. Recreate the systemd units and scripts (see Open items; they are not yet in the repo).

## Open items

Roughly in priority order.

1. **Reverse proxy and trusted HTTPS: decision pending.** The goal is to remove the browser "not secure" warning and the port numbers. Options considered:
   - *Tailscale Services*: free, gives `https://<name>.<tailnet>.ts.net` on port 443. Requires tagging Bobcat (tag-based identity) and defining each service in the admin console. Postponed.
   - *Caddy plus a domain* (about $10-15/yr, DNS-challenge certificates): gives `<name>.home.<domain>`. Undecided. A bare `homarr.bobcat` is not possible without running your own DNS.
   - *Do nothing*: the current setup works and the warning is cosmetic.
2. **Put scripts and units in the repo** (for example `host/`): the restic scripts, their systemd units, and the Docker drop-in, committed from the laptop, so recovery doesn't depend on Bobcat's own disk.
3. **Pin image versions** and use Renovate or Dependabot to propose updates, instead of `:latest`.
4. **Restic password** must also be stored in a password manager. It is currently confirmed only at `/root/.config/restic/password`.
5. **Test a restore** at least once.
6. **Backup failure alerts** (for example a healthchecks.io ping at the end of each restic script): deliberately skipped for now.
7. **Offsite backup** to Backblaze B2 (future goal).
8. **Delete leftover data** in `/srv/docker/{minecraft,vikunja,uptime-kuma,seafile}` once you're sure you won't revive them.

## Deferred

Netgate/pfSense project ("Crow"): paused indefinitely and not an active project.
