# Backups

## Goal

Backups protect homelab data that cannot be easily recreated from the repository.

The Git repository can recreate structure.

Backups restore data.

## Tools

- restic
- rclone

## Backup targets

### Bobcat

Back up:

```text
/opt/homelab
/mnt/seafile-data