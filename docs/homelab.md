# Homelab: Bobcat

Last updated: 2026-10-02

This is the single reference for the homelab. It describes what is actually running and how it is deployed, backed up, and recovered. Anything not yet verified is listed under "Open items".

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
| OS | Debian, headless |
| Admin user | `jackson` |
| LAN IP | `192.168.254.149` (static, DHCP reservation on the Google Nest Pro) |
| Gateway | `192.168.254.1` (Google Nest Pro: routing, DHCP, DNS, firewall) |
| Remote access | Tailscale |
| Public exposure | None. The Minecraft tunnel (Playit) was retired on 2026-10-02: package purged, tunnel deleted in the playit.gg dashboard. |

Services are reached by raw IP and port. There is no reverse proxy and no local DNS.

## Storage

| Mount | Device | Purpose |
|---|---|---|
| NVMe (root) | internal 1 TB | Debian, Docker runtime, app data in `/srv/docker/<stack>` |
| `/mnt/media` | 6 TB HDD, USB | Media and downloads |
| `/mnt/backups` | 256 GB SSD, USB | Restic repository at `/mnt/backups/restic` |

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

## Running services

All services run in Docker and are defined in the repo.

**Media stack** (`stacks/media`): Jellyfin (with `/dev/dri` passed through for hardware transcoding), Sonarr, Radarr, Lidarr, Bazarr, Prowlarr, SABnzbd, Seerr. Seerr handles requests. SABnzbd is the download client and writes to `/mnt/media/downloads`.

**Dashboard** (`stacks/homarr`): Homarr.

Images are currently tagged `:latest`, and updates are manual (`docker compose pull && docker compose up -d`). No auto-updater is installed.

## Retired services

Wound down on 2026-10-02: Minecraft (PaperMC/Geyser/Floodgate), Seafile, Vikunja, and Uptime Kuma. Containers were removed with `docker compose down`, and their stacks were moved to `stacks/_archived/` in the repo. See `stacks/_archived/README.md` for how to revive them.

- Their data directories were left in `/srv/docker/<stack>` (Seafile's was judged disposable).
- Their real `.env` files are in `stacks/_archived/<stack>/.env` on Bobcat (gitignored).
- Older restic snapshots still contain their data until they age out of retention.
- Monitoring: nothing is deployed now that Kuma is gone. Grafana, Prometheus, Loki and similar are intentionally not used.

## Repository and deployment

- Repo: `github.com/JacksonTaylor2003/Homelab`
- Clone on Bobcat: `/opt/homelab-repo`
- Layout: `stacks/media`, `stacks/homarr`, `stacks/_archived/*`

**Workflow:** edit on the laptop, commit and push, then on Bobcat run `git pull` and `docker compose up -d` in the relevant stack. Bobcat never pushes.

**Secrets:** real `.env` files live next to each compose file (`stacks/<stack>/.env`) and are gitignored (`stacks/**/.env`, `*.env`, `secrets/`). Only `.env.example` files with placeholder values are tracked.

**Gotcha:** an uncommitted edit to a tracked file on Bobcat makes `git pull` abort. Run `git status --short` first. It should print nothing.

## Backups

Tool: Restic. Repository: `/mnt/backups/restic`. Password file: `/root/.config/restic/password`. Retention: 7 daily, 4 weekly, 6 monthly. Size is about 2.6 GiB, so the backup drive has plenty of headroom.

| Job | Schedule | Script | Contents |
|---|---|---|---|
| `restic-apps` | Daily 03:00 | `/usr/local/bin/restic-apps.sh` | `/srv/docker`, tag `apps` |
| `restic-system` | Sundays 04:00 | `/usr/local/bin/restic-system.sh` | `/etc`, `/opt/homelab-repo`, `/home/jackson/.ssh`, tag `system` |

How the apps job works: it first checks that `/mnt/backups` is mounted, stops the `media` and `homarr` stacks (a cold backup, so databases are consistent), runs `restic backup`, applies retention with `forget --prune`, and restarts the stacks through an exit trap. The system job has the same mount check.

Excluded: media content and the download cache.

Because `.env` files sit inside `/opt/homelab-repo`, they are captured by the system job, not the apps job.

**The scripts and unit files live only on Bobcat** (`/usr/local/bin`, `/etc/systemd/system`). They are not in the repo. If you change the set of stacks, the `STACKS=(...)` line in `restic-apps.sh` must change too.

Useful commands:

```bash
sudo systemctl list-timers --no-pager
sudo journalctl -u restic-apps.service -n 30 --no-pager
sudo RESTIC_REPOSITORY=/mnt/backups/restic RESTIC_PASSWORD_FILE=/root/.config/restic/password restic snapshots
```

## Recovery outline

1. Install Debian, Docker, and Tailscale. Mount the drives at `/mnt/media` and `/mnt/backups`.
2. Restore the Restic password from the password manager, then restore the latest `system` and `apps` snapshots (`restic restore latest --tag system --target /`).
3. Clone the repo to `/opt/homelab-repo` and confirm each stack's `.env` is present.
4. Run `docker compose up -d` in `stacks/media` and `stacks/homarr`.
5. Recreate the systemd units and scripts (see Open items; they are not yet in the repo).

## Open items

Roughly in priority order.

1. **Failure alerts for backups.** Nothing notifies you if a backup fails or if Bobcat goes down. Plan: add a healthchecks.io ping to the end of each restic script.
2. **Confirm the `restic-system` run** after the repo move, and that the moved `.env` files appear in a snapshot.
3. **Restic password** must also be stored in a password manager. It is currently confirmed only at `/root/.config/restic/password`.
4. **Put scripts and units in the repo** (for example `host/`), committed from the laptop, so recovery doesn't depend on Bobcat's own disk.
5. **Pin image versions** and use Renovate or Dependabot to propose updates, instead of `:latest`.
6. **Test a restore** at least once.
7. **Check drive mounts:** confirm both USB drives mount by UUID in `/etc/fstab` with `nofail`.
8. **Offsite backup** to Backblaze B2 (future goal).
9. **Reverse proxy** (internal only). Leading options: Tailscale Serve (no domain needed) or Caddy with a domain and DNS-challenge certificates. Caddy is preferred over Nginx Proxy Manager or Traefik because its config is a small file that fits in the repo. The Nest Pro probably cannot serve custom local DNS records (unconfirmed).
10. **Delete leftover data** in `/srv/docker/{minecraft,vikunja,uptime-kuma,seafile}` once you're sure you won't revive them.

## Deferred

Netgate/pfSense project ("Crow"): paused indefinitely and not an active project.
