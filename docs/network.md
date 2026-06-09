# Network

## Network authority

Crow is the network authority.

Responsibilities:

- Routing
- Firewall
- VLANs
- DHCP
- WireGuard VPN

## VLANs

| VLAN | Name | Purpose | Example devices |
|---|---|---|---|
| 10 | Trusted | Personal trusted devices | Laptop, phone, desktop |
| 20 | Homelab | Servers and infrastructure | Bobcat, Anole, Hoverfly |
| 30 | IoT | Smart home devices | Google Home, Kasa plugs |
| TBD | Management | Infrastructure administration | Router UI, switch UI, server admin |

## Access rules draft

Initial policy:

- Trusted devices can access homelab services.
- Homelab devices can access the internet for updates.
- IoT devices cannot access homelab services.
- VPN users can access trusted and homelab services.
- Public access is avoided except Minecraft through playit.gg.

## DNS names draft

| Service | Hostname | Target |
|---|---|---|
| Jellyfin | `jellyfin.home.arpa` | Bobcat |
| Seafile | `seafile.home.arpa` | Bobcat |
| Vikunja | `vikunja.home.arpa` | Bobcat |
| Gitea | `gitea.home.arpa` | Anole |
| Homer | `homer.home.arpa` | Anole |
| Grafana | `grafana.home.arpa` | Anole |
| Prometheus | `prometheus.home.arpa` | Hoverfly |