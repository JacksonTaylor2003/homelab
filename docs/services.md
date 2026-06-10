# Services

## Service inventory

| Service | Host | Stack | Purpose | Public? |
|---|---|---|---|---|
| Jellyfin | Bobcat | media | Media server | No |
| Sonarr | Bobcat | media | TV automation | No |
| Radarr | Bobcat | media | Movie automation | No |
| Lidarr | Bobcat | media | Music automation | No |
| Bazarr | Bobcat | media | Subtitles automation | No |
| Seerr | Bobcat | media | Request automation | No |
| Prowlarr | Bobcat | media | Indexer management | No |
| SABnzbd | Bobcat | media | Download client | No |
| Seafile | Bobcat | seafile | File sync/storage | No |
| Vikunja | Bobcat | vikunja | Task management | No |
| Minecraft | Bobcat | minecraft | Game server | Yes, through playit.gg |
| Gitea | Anole | gitea | Git hosting | No |
| Homarr | Anole | homarr | Dashboard | No |
| Grafana | Anole | grafana | Metrics dashboard | No |
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
- Bazarr
- Seerr
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

### `stacks/homarr`

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