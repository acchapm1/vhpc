FROM rockylinux:9.7

RUN dnf -y update && dnf -y install epel-release &&     dnf -y install nfs-utils e2fsprogs util-linux sudo supervisor wget bzip2 &&     dnf -y clean all

COPY supervisord.conf /etc/supervisord.conf
COPY start-storage.sh /usr/local/bin/start-storage.sh
RUN chmod +x /usr/local/bin/start-storage.sh

EXPOSE 2049 111
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
