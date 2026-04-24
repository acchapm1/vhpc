HPC Docker Compose (Rocky Linux 9.7) with Slurm built from source (25.05.x)

This project creates a small simulated HPC cluster using Docker Compose:
- head: Slurm controller (slurmctld) + login node
- compute1, compute2: slurmd compute nodes (2 CPUs, 6GiB each)
- storage: NFS export backed by a 10 GiB image file

Important choices made:
- Guest OS: Rocky Linux 9.7
- Slurm: compiled from source using the latest patch in the 25.05 series (25.05.6 at time of packaging).
  Sources and release notes: see SchedMD download page and release announcement included in docs.

How to use (summary):
1. On the host, install Docker and Docker Compose (v1.29+ or the Compose plugin).
2. From this project root, build images:
   docker-compose build
3. Start services:
   docker-compose up -d
4. Follow the README sections and the scripts to copy munge key, distribute slurm conf, mount NFS, and start slurm daemons.

Files included:
- docker-compose.yml
- head/, compute/, storage/ directories with Dockerfiles and supervisord scripts
- slurm-build/ contains the build instructions used in the Dockerfiles

Notes:
- Building Slurm from source inside the images will take time and add to image size.
- The Slurm source tarball used: slurm-25.05.6.tar.bz2 (SchedMD). See LICENSE and SchedMD release notes for details.

Caveats:
- This setup is intended for testing/demos, not production.
- Storage container runs privileged to allow loopback mounting for the 10 GiB backing file.
