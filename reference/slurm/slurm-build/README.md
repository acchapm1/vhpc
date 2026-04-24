This directory documents how the Dockerfiles build Slurm from source.

Slurm source used: slurm-25.05.6.tar.bz2 (from SchedMD).
Direct download reference: https://download.schedmd.com/slurm/slurm-25.05.6.tar.bz2

Basic build steps used in Dockerfiles:
- install build dependencies
- download and extract tarball
- ./configure --prefix=/opt/slurm --sysconfdir=/etc/slurm
- make -j$(nproc)
- make install
- install/enable systemd units or use supervisord to run slurmctld/slurmd

See the Dockerfiles in head/ and compute/ for the exact automated commands.
