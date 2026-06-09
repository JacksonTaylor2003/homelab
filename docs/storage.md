# Storage Layout

## Bobcat

Bobcat has two main storage roles:

- NVMe for application data, databases, configs, and fast-changing service data
- HDD for large media files, downloads, and Seafile file storage

## NVMe paths
```text
/opt/homelab
```

#### Used for:
- Container config
- Databases
- Minecraft world data
- Vikunja data
- ARR stack config
- Jellyfin config
- Seafile metadata/config

#### Stack paths:
- /opt/homelab/media
- /opt/homelab/seafile
- /opt/homelab/vikunja
- /opt/homelab/minecraft

## HDD paths
```text
/mnt/media
/mnt/downloads
/mnt/seafile-data
```
#### Examples
- /media/movies
- /media/tv
- /media/music
- /downloads/complete
- /downloads/incomplete

#### Used for:
- Movies
- TV
- Music
- Downloads
- Seafile file library

## Anole
```text
/opt/homelab/gitea
/opt/homelab/homer
/opt/homelab/grafana
```

## Hoverfly
```text
/opt/homelab/prometheus
/opt/homelab/loki
/opt/homelab/alertmanager
```

## Rule
Fast-changing application state belongs on NVMe.
Large replaceable files belong on HDD.