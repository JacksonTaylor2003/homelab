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

### Create Minecraft directories

```bash
sudo mkdir -p /opt/homelab/minecraft/data
sudo chown -R 1000:1000 /opt/homelab/minecraft
```
### Create Monitorting directories

# Anole
```bash
sudo mkdir -p /opt/homelab/grafana/data
sudo chown -R 472:472 /opt/homelab/grafana
```

# Hoverfly
```bash
sudo mkdir -p \
  /opt/homelab/monitoring/prometheus \
  /opt/homelab/monitoring/alertmanager \
  /opt/homelab/monitoring/loki \
  /opt/homelab/monitoring/uptime-kuma

sudo chown -R 1000:1000 /opt/homelab/monitoring
```

### Create Monitoring configs

```bash
sudo cp stacks/monitoring/prometheus.example.yml /opt/homelab/monitoring/prometheus.yml
sudo cp stacks/monitoring/alert-rules.example.yml /opt/homelab/monitoring/alert-rules.yml
sudo cp stacks/monitoring/alertmanager.example.yml /opt/homelab/monitoring/alertmanager.yml
sudo cp stacks/monitoring/loki-config.example.yml /opt/homelab/monitoring/loki-config.yml

sudo chown 1000:1000 \
  /opt/homelab/monitoring/prometheus.yml \
  /opt/homelab/monitoring/alert-rules.yml \
  /opt/homelab/monitoring/alertmanager.yml \
  /opt/homelab/monitoring/loki-config.yml
```