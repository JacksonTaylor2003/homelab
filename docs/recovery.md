# Recovery

## Crow Failure

Rebuild router configuration.

Restore:

- VLANs
- DHCP
- Firewall rules
- WireGuard

## Bobcat Failure

Install Debian.

Install Docker.

Clone repository.

Restore:

- /opt/homelab
- /mnt/media
- /mnt/downloads
- /mnt/seafile-data

Deploy:

- media
- seafile
- vikunja
- minecraft

## Anole Failure

Install Debian.

Install Docker.

Clone repository.

Restore:

- /opt/homelab/homer
- /opt/homelab/grafana

Deploy:

- homer
- grafana

## Hoverfly Failure

Install Debian.

Install Docker.

Clone repository.

Restore:

- /opt/homelab/monitoring

Deploy:

- monitoring
- node-exporter