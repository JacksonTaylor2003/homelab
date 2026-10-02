# Archived stacks

Wound down on 2026-10-02. Containers removed; data left on Bobcat in /srv/docker/<service>.

- minecraft (also: playit.service disabled, tunnel deleted)
- seafile (+ seafile-db, seafile-cache)
- vikunja (+ vikunja-db)
- uptime-kuma

To revive: `git mv` the folder back into `stacks/`, restore its real `.env`, then `docker compose up -d`.
