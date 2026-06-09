# Services

## Service inventory

| Service | Host | Stack | Purpose | Public? |
|---|---|---|---|---|
| Jellyfin | Bobcat | media | Media server | No |
| Sonarr | Bobcat | media | TV automation | No |
| Radarr | Bobcat | media | Movie automation | No |
| Prowlarr | Bobcat | media | Indexer management | No |
| qBittorrent | Bobcat | media | Download client | No |
| Seafile | Bobcat | seafile | File sync/storage | No |
| Vikunja | Bobcat | vikunja | Task management | No |
| Minecraft | Bobcat | minecraft | Game server | Yes, through playit.gg |
| Gitea | Anole | gitea | Git hosting | No |
| Homer | Anole | homer | Dashboard | No |
| Grafana | Anole | monitoring | Metrics dashboard | No |
| Prometheus | Hoverfly | monitoring | Metrics collection | No |
| Alertmanager | Hoverfly | monitoring | Alert routing | No |
| Loki | Hoverfly | monitoring | Log aggregation | No |
| Node Exporter | All hosts | monitoring | Host metrics | No |

## Stack ownership

### `stacks/media`

Runs on Bobcat.

Services:

- Jellyfin
- Sonarr
- Radarr
- Lidarr
- Prowlarr
- SABnzbd

Owns:

- Media library
- Download directories
- ARR application config

### `stacks/seafile`

Runs on Bobcat.

Owns:

- Personal files
- Seafile database
- Seafile application data

### `stacks/vikunja`

Runs on Bobcat.

Owns:

- Task data
- Vikunja database

### `stacks/minecraft`

Runs on Bobcat.

Owns:

- Minecraft world data
- Server config
- Plugin config

### `stacks/gitea`

Gitea is deferred. GitHub is currently used as the source-of-truth repository.

Runs on Anole.

Owns:

- Git repositories
- Gitea database
- Gitea config

### `stacks/homer`

Runs on Anole.

Owns:

- Dashboard config

### `stacks/monitoring`

Runs mainly on Hoverfly.

Owns:

- Prometheus data
- Alertmanager config
- Loki logs
- Grafana dashboards