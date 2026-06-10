# Host Setup

## Clone Repository

```bash
sudo mkdir -p /opt/homelab-repo
sudo chown $USER:$USER /opt/homelab-repo

git clone https://github.com/JacksonTaylor2003/Homelab.git /opt/homelab-repo

git clone git@github.com:JacksonTaylor2003/Homelab.git homelab-repo
```

## Bobcat

- /opt/homelab-repo = blueprint
- /opt/homelab      = runtime app data
- /mnt              = large persistent storage

### Create application directories

```bash
sudo mkdir -p \
  /opt/homelab/media/{jellyfin,sonarr,radarr,lidarr,prowlarr,seerr,bazarr,sabnzbd} \
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

### Create Minecraft directories

```bash
sudo mkdir -p /opt/homelab/minecraft/data
sudo chown -R 1000:1000 /opt/homelab/minecraft
```

## Anole

### Create Homarr directories

```bash
sudo mkdir -p /opt/homelab/homarr
sudo chown -R 1000:1000 /opt/homelab/homarr
```

## Monitoring

### Create Monitoring directories

## Anole
```bash
sudo mkdir -p /opt/homelab/grafana/data
sudo chown -R 472:472 /opt/homelab/grafana
```

## Hoverfly
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

## Create Runtime Configuration Files

## Bobcat

```bash
cp /opt/homelab-repo/stacks/media/.env.example \
   /opt/homelab/media/.env

cp /opt/homelab-repo/stacks/seafile/.env.example \
   /opt/homelab/seafile/.env

cp /opt/homelab-repo/stacks/vikunja/.env.example \
   /opt/homelab/vikunja/.env

cp /opt/homelab-repo/stacks/minecraft/.env.example \
   /opt/homelab/minecraft/.env
```

## Anole

```bash
cp /opt/homelab-repo/stacks/homarr/.env.example \
   /opt/homelab/homarr/.env

cp /opt/homelab-repo/stacks/grafana/.env.example \
   /opt/homelab/grafana/.env
```

## Hoverfly

```bash
cp /opt/homelab-repo/stacks/monitoring/.env.example \
   /opt/homelab/monitoring/.env
```

## Edit Runtime Configuration Files

Review every `.env` file and replace:

- Hostnames
- Email addresses
- Passwords
- API keys
- Secrets

before deploying any stack.