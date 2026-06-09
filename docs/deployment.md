# Deployment Plan

## Bobcat

Stacks:

- media
- seafile
- vikunja
- minecraft

## Anole

Stacks:

- gitea
- homer

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

docker compose -f stacks/homer/compose.yml up -d

### Hoverfly

docker compose -f stacks/monitoring/compose.yml up -d