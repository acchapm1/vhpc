FROM rockylinux:9.7

ENV container docker

# Install basic packages and build deps for Slurm
RUN dnf -y update && dnf -y install epel-release &&     dnf -y install       passwd openssh-server openssh-clients sudo vim tar iputils which       nfs-utils wget python3 perl redhat-rpm-config gcc gcc-c++ make automake       autoconf flex bison numactl-devel hwloc-devel openssl-devel pam-devel       libacl-devel readline-devel which git perl-ExtUtils-Embed pcre-devel       lua-devel mariadb-connector-c-devel rpm-build munge munge-libs       munge-devel rpmdevtools supervisor tar xz bzip2 &&     dnf -y clean all

# Create slurm and munge users
RUN useradd -m slurm || true
RUN useradd -m -u 997 munge || true

# Add slurm build/install; the Dockerfile will download slurm source and compile it
COPY ../slurm-build /slurm-build
ARG SLURM_VERSION=25.05.6
ARG SLURM_TARBALL=https://download.schedmd.com/slurm/slurm-${SLURM_VERSION}.tar.bz2

RUN mkdir -p /opt/slurm-src &&     cd /opt/slurm-src &&     wget -O slurm.tar.bz2 ${SLURM_TARBALL} &&     tar -xjf slurm.tar.bz2 --strip-components=1 &&     ./configure --prefix=/opt/slurm --sysconfdir=/etc/slurm &&     make -j$(nproc) && make install

# Put slurm binaries on PATH
ENV PATH="/opt/slurm/bin:/opt/slurm/sbin:${PATH}"

# SSH and supervisord setup
RUN mkdir -p /var/run/sshd /var/spool/slurmd /var/spool/slurmctld &&     echo "root:root" | chpasswd

COPY supervisord.conf /etc/supervisord.conf
COPY slurm.conf /etc/slurm/slurm.conf
COPY start-head.sh /usr/local/bin/start-head.sh
RUN chmod +x /usr/local/bin/start-head.sh

EXPOSE 22
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
