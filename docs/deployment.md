# Deployment Plan

## Bobcat

Stacks:

- media
- seafile
- vikunja
- minecraft

## Anole

Stacks:

- gitea (later)
- homarr
- grafana

## Hoverfly

Stacks:

- monitoring

## Deployment Commands

### Bobcat

docker compose -f stacks/media/compose.yml up -d

docker compose -f stacks/seafile/compose.yml up -d

docker compose -f stacks/vikunja/compose.yml up -d

docker compose -f stacks/minecraft/compose.yml up -d

### Anole

docker compose -f stacks/gitea/compose.yml up -d

docker compose -f stacks/homarr/compose.yml up -d

docker compose -f ~/homelab/stacks/grafana/compose.yml up -d

### Hoverfly

docker compose -f stacks/monitoring/compose.yml up -d

### Shared Host Monitoring

The `node-exporter` stack should run on every host:

- Bobcat
- Anole
- Hoverfly

Deployment command:

```bash
docker compose -f stacks/node-exporter/compose.yml up -d
```