# Host Setup

## Bobcat

### Create application directories

```bash
sudo mkdir -p \
  /opt/homelab/media/{jellyfin,sonarr,radarr,lidarr,prowlarr,sabnzbd} \
  /opt/homelab/seafile \
  /opt/homelab/vikunja \
  /opt/homelab/minecraft
```

### Create media directories

```bash
sudo mkdir -p \
  /mnt/media/{movies,tv,music} \
  /mnt/downloads/{complete,incomplete} \
  /mnt/seafile-data
```

### Set ownership

```bash
sudo chown -R 1000:1000 \
  /opt/homelab \
  /mnt/media \
  /mnt/downloads \
  /mnt/seafile-data
```