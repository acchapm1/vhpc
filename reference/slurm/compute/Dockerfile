FROM rockylinux:9.7

ENV container docker

RUN dnf -y update && dnf -y install epel-release &&     dnf -y install       passwd openssh-server sudo supervisor munge munge-libs munge-devel       nfs-utils wget python3 gcc gcc-c++ make automake autoconf       numactl-devel hwloc-devel openssl-devel pam-devel libacl-devel       readline-devel lua-devel bzip2 &&     dnf -y clean all

RUN useradd -m slurm || true
RUN useradd -m -u 997 munge || true

# Build Slurm from source in the image (same version)
ARG SLURM_VERSION=25.05.6
ARG SLURM_TARBALL=https://download.schedmd.com/slurm/slurm-${SLURM_VERSION}.tar.bz2

RUN mkdir -p /opt/slurm-src &&     cd /opt/slurm-src &&     wget -O slurm.tar.bz2 ${SLURM_TARBALL} &&     tar -xjf slurm.tar.bz2 --strip-components=1 &&     ./configure --prefix=/opt/slurm --sysconfdir=/etc/slurm &&     make -j$(nproc) && make install

ENV PATH="/opt/slurm/bin:/opt/slurm/sbin:${PATH}"

RUN mkdir -p /var/run/sshd /var/spool/slurmd && echo "root:root" | chpasswd

COPY supervisord.conf /etc/supervisord.conf
COPY start-compute.sh /usr/local/bin/start-compute.sh
RUN chmod +x /usr/local/bin/start-compute.sh

EXPOSE 22
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
