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

### Create Seafile directories

```bash
sudo mkdir -p \
  /opt/homelab/seafile/db \
  /opt/homelab/seafile/shared \
  /mnt/seafile-data

sudo chown -R 1000:1000 \
  /opt/homelab/seafile \
  /mnt/seafile-data
```

### Create Vikunja directories

```bash
sudo mkdir -p \
  /opt/homelab/vikunja/db \
  /opt/homelab/vikunja/files

sudo chown -R 1000:1000 /opt/homelab/vikunja
```

### Create Homer directories

```bash
sudo mkdir -p /opt/homelab/homer/assets
sudo chown -R 1000:1000 /opt/homelab/homer
```

### Create Homer config

```bash
sudo cp stacks/homer/config.example.yml /opt/homelab/homer/assets/config.yml
sudo chown 1000:1000 /opt/homelab/homer/assets/config.yml
```