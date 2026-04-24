#!/bin/bash
mkdir -p /var/spool/slurmd
chown -R slurm:slurm /var/spool/slurmd
exec /usr/bin/supervisord -c /etc/supervisord.conf
