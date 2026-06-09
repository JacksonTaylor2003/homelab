# Homelab

This repository documents and deploys my homelab infrastructure.

## Design goals

- Reproducible infrastructure
- Clear service ownership
- VPN-first access
- Minimal public exposure
- Docker-based service deployment
- Documentation before automation

## Devices

| Host | Device | Role |
|---|---|---|
| Crow | Netgate SG-1100 | Router / network authority |
| Bobcat | Beelink EQi13 Pro | Compute / Docker workloads |
| Anole | Raspberry Pi 5 | Control / coordination |
| Hoverfly | Raspberry Pi 5 | Monitoring / alerting |

## Repository layout

| Path | Purpose |
|---|---|
| `ansible/` | Future automation |
| `docs/` | Architecture and recovery documentation |
| `docs/runtime.md` | Runtime paths and deployment conventions |
| `docs/host-setup.md` | Initial server preparation steps |
| `stacks/` | Docker Compose stacks |
| `scripts/` | Helper scripts |
| `secrets/` | Local-only secrets, not committed |

## Current phase

Building the repository structure and documenting intended services before writing final Compose files.