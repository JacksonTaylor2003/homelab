# Storage Layout

## Bobcat Storage

### Internal NVMe (1 TB)

Purpose: Active application data and configuration.

Mounts:

```text
/srv/docker
```

Structure:

```text
/srv/docker
├── homarr
├── media
├── minecraft
├── seafile
├── uptime-kuma
└── vikunja
```

Contents:

* Container configurations
* Databases
* Minecraft world data
* Seafile data
* Application state

---

### External Media HDD (6 TB)

Mount point:

```text
/mnt/media
```

Purpose:

* Media storage only

Structure:

```text
/mnt/media
├── downloads
│   ├── complete
│   └── incomplete
├── movies
├── music
└── tv
```

---

### External Backup SSD (256 GB)

Mount point:

```text
/mnt/backups
```

Purpose:

* Backup destination only

Structure:

```text
/mnt/backups
├── apps
└── system
```

---

## Backup Sources

### Applications

Source:

```text
/srv/docker
```

Destination:

```text
/mnt/backups/apps
```

Includes:

* Homarr
* Media stack configuration
* Minecraft
* Seafile
* Uptime Kuma
* Vikunja

### System

Sources:

```text
/opt/homelab-repo
/etc
```

Destination:

```text
/mnt/backups/system
```

Includes:

* Homelab repository
* System configuration
* Recovery documentation

```
```
