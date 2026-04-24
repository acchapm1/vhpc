#!/bin/bash
# helper: ensure directories and start supervisord (supervisord is CMD)
mkdir -p /var/spool/slurmd /var/spool/slurmctld
chown -R slurm:slurm /var/spool/slurmd /var/spool/slurmctld
exec /usr/bin/supervisord -c /etc/supervisord.conf
