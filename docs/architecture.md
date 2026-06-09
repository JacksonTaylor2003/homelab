# Architecture

## Core model

The homelab is split by responsibility:

- Crow owns the network.
- Bobcat runs main application workloads.
- Anole runs control-plane services.
- Hoverfly observes the environment and alerts when something breaks.

## Device roles

### Crow

Crow is the router and network authority.

Responsibilities:

- VLANs
- DHCP
- Firewall rules
- VPN access

### Bobcat

Bobcat is the main compute node.

Responsibilities:

- Jellyfin
- ARR stack
- Seafile
- Vikunja
- Minecraft

All Bobcat services run in Docker.

### Anole

Anole is the control node.

Responsibilities:

- Gitea
- Homer
- Grafana

### Hoverfly

Hoverfly is the monitoring node.

Responsibilities:

- Prometheus
- Alertmanager
- Loki
- Node Exporter
- Optional: Uptime Kuma

## Access model

Services are accessed through the local network or WireGuard VPN.

No reverse proxy is planned right now.
No general public HTTP/S exposure is planned.