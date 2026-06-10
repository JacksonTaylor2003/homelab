# Deployment Plan

## Deployment Order

Deploy hosts in the following order:

1. Crow (Network Authority)
2. Bobcat (Compute)
3. Anole (Control)
4. Hoverfly (Monitoring)

Complete all steps in `host-setup.md` before deploying any stack.

---

## Bobcat

### Stacks

* media
* seafile
* vikunja
* minecraft

### Deployment Commands

#### Media Stack

```bash
cd /opt/homelab-repo/stacks/media
docker compose up -d
```

#### Seafile

```bash
cd /opt/homelab-repo/stacks/seafile
docker compose up -d
```

#### Vikunja

```bash
cd /opt/homelab-repo/stacks/vikunja
docker compose up -d
```

#### Minecraft

```bash
cd /opt/homelab-repo/stacks/minecraft
docker compose up -d
```

### Verify

* Jellyfin accessible
* Sonarr accessible
* Radarr accessible
* Lidarr accessible
* Prowlarr accessible
* SABnzbd accessible
* Seerr accessible
* Bazarr accessible
* Seafile accessible
* Vikunja accessible
* Minecraft server starts successfully

---

## Anole

### Stacks

* homarr
* grafana

### Future Stacks

* gitea

### Deployment Commands

#### Homarr

```bash
cd /opt/homelab-repo/stacks/homarr
docker compose up -d
```

#### Grafana

```bash
cd /opt/homelab-repo/stacks/grafana
docker compose up -d
```

### Verify

* Homarr accessible
* Grafana accessible

---

## Hoverfly

### Stacks

* monitoring

### Deployment Commands

#### Monitoring

```bash
cd /opt/homelab-repo/stacks/monitoring
docker compose up -d
```

### Verify

* Prometheus running
* Alertmanager running
* Loki running
* Uptime Kuma running

---

## Shared Host Monitoring

The node-exporter stack should run on:

* Bobcat
* Anole
* Hoverfly

### Deployment Command

```bash
cd /opt/homelab-repo/stacks/node-exporter
docker compose up -d
```

### Verify

Confirm each host appears as a scrape target in Prometheus.

---

## Post-Deployment Tasks

### Media Integrations

Configure:

* Prowlarr → Sonarr
* Prowlarr → Radarr
* Prowlarr → Lidarr
* Sonarr → SABnzbd
* Radarr → SABnzbd
* Lidarr → SABnzbd
* Seerr → Sonarr
* Seerr → Radarr
* Bazarr → Sonarr
* Bazarr → Radarr
* Jellyfin libraries

### Monitoring

Configure:

* Prometheus scrape targets
* Grafana data sources
* Alertmanager notification routes
* Uptime Kuma monitors

### Dashboard

Add all services to Homarr.
