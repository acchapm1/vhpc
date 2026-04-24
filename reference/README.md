# reference/

Prior-art code kept for future reuse. Not wired into any current build.
Neither subdirectory is actively maintained — treat them as frozen snapshots.

## slurm/

Docker Compose HPC cluster (Rocky Linux 9.7) with **Slurm built from source
(25.05.x)**. Head / compute / storage nodes plus a `slurm-build/` stage.
Includes working `slurm.conf` and `cgroup.conf`.

Why kept: `docker-vhpc/` and `kubevirt-vhpc/` explicitly leave Slurm out of
scope (`docker-vhpc/SPECS.md` says "No Slurm/PBS scheduler — can be added
via Ansible"). If you ever want to add a scheduler to either project, this
is a known-working starting point.

## terraform-libvirt-sample/

Terraform + libvirt recipe for provisioning a QEMU/KVM VM on a hypervisor
host. Different substrate from `docker-vhpc/` (containers) and
`kubevirt-vhpc/` (Kubernetes VMs).

Why kept: if a "bare libvirt, no Kubernetes" path is ever needed — e.g. for
single-hypervisor on-prem deployment — this is the starting point.
