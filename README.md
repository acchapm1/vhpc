# vHPC — Virtual HPC Cluster Workspace

A workspace holding multiple implementations of a virtual HPC (High Performance
Computing) cluster for testing, development, and learning. Each project builds
the *same* conceptual cluster — head + compute + storage nodes with NFS-shared
storage, passwordless SSH, and a default `rocky` user — on a different
substrate.

This repository is a collection of independent projects. Each subdirectory is
self-contained: `cd` into it before running any commands.

## Projects

| Project                              | Substrate                  | Description                                                             |
| ------------------------------------ | -------------------------- | ----------------------------------------------------------------------- |
| [`docker-vhpc/`](docker-vhpc/)       | Docker / Docker Compose    | Container-based vHPC cluster (Rocky Linux 9.7 and 10.1 variants)        |
| [`kubevirt-vhpc/`](kubevirt-vhpc/)   | KubeVirt on Kubernetes     | VM-based vHPC cluster on Kubernetes (Rocky Linux 9 and 10 variants)     |
| [`reference/`](reference/)           | Frozen prior-art           | Slurm-from-source and Terraform+libvirt samples kept for future reuse   |

Both `docker-vhpc/` and `kubevirt-vhpc/` implement the same cluster topology on
different substrates. Patterns and naming are intentionally aligned between the
two — when changing one, consider whether the other needs the same treatment.

## Cluster Topology

Each project provisions:

- **Head node** — Login / management node with SSH access
- **Compute nodes** — Scalable processing workers (configurable count)
- **Storage node** — Shared NFS storage mounted across all nodes

Default credentials (dev-only): `rocky` / `Sp@rky26`, `root` / `root`.

## Prerequisites

Common across projects:

- [`just`](https://github.com/casey/just) — task runner used by every project

Project-specific:

- **docker-vhpc** — Docker + Docker Compose, optionally Ansible 2.14+
- **kubevirt-vhpc** — `kubectl`, `minikube` (or compatible Kubernetes), SSH keys

## Quick Start

Pick a project and a Rocky Linux version, then run `just`:

```bash
# Docker-based cluster
cd docker-vhpc/rocky9
just setup
just ssh rocky

# KubeVirt-based cluster
cd kubevirt-vhpc/rocky9
just check-prereqs
just full-deploy
just ssh-head
```

Run `just` (with no arguments) in any project directory to list available
recipes.

## Conventions

- **`just` is the entry point.** Don't invoke `docker-compose`, `kubectl
  apply`, or `ansible-playbook` directly — the recipes wire in template
  generation, namespace fallbacks, and SSH key distribution.
- **Configuration lives in `Justfile` variables** (port numbers, network
  names, node counts, memory sizing). Template files are rendered into
  generated artifacts; never edit the generated files directly.
- **Naming follows `{variant}-{role}-{NN}`** with zero-padded numbers
  (e.g. `asu-head-01`, `asu-compute-02`).
- **Default credentials are dev-only** and appear in cloud-init configs and
  Dockerfiles intentionally. Don't replace them with secrets management
  unless the task is explicitly about productionizing.

See each project's `README.md` and `HOWTO.md` for full details.

## License

MIT License
