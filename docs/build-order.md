# Build Order

## Phase 1 - Network

- [ ] Configure Crow
- [ ] Create VLANs
- [ ] Configure WireGuard
- [ ] Configure DNS

## Phase 2 - Bobcat

- [ ] Install Debian
- [ ] Update system
- [ ] Install Docker
- [ ] Clone repository
- [ ] Configure storage mounts
- [ ] Create runtime directories
- [ ] Create .env files

## Phase 3 - Core Services

- [ ] Deploy media stack
- [ ] Configure Jellyfin
- [ ] Configure Sonarr
- [ ] Configure Radarr
- [ ] Configure Lidarr
- [ ] Configure Prowlarr
- [ ] Configure SABnzbd

- [ ] Deploy Seafile
- [ ] Configure Seafile

- [ ] Deploy Vikunja
- [ ] Configure Vikunja

## Phase 4 - Control Plane

- [ ] Install Debian on Anole
- [ ] Install Docker
- [ ] Clone repository
- [ ] Deploy Homer
- [ ] Deploy Grafana

## Phase 5 - Monitoring

- [ ] Install Debian on Hoverfly
- [ ] Install Docker
- [ ] Clone repository
- [ ] Deploy monitoring stack
- [ ] Deploy node-exporter everywhere
- [ ] Configure Grafana dashboards

## Phase 6 - Minecraft

- [ ] Deploy PaperMC
- [ ] Install Geyser
- [ ] Install Floodgate
- [ ] Configure playit.gg

## Phase 7 - Backups

- [ ] Configure rclone
- [ ] Configure restic
- [ ] Test backup
- [ ] Test restore

## Phase 8 - Automation

- [ ] Configure Ansible inventory
- [ ] Verify connectivity
- [ ] Create Docker playbook
- [ ] Create directory playbook
- [ ] Automate deployments