#!/bin/bash
set -e
source "$(dirname "$0")/config.sh"

echo "[attack] Running from Kali..."
ssh "${KALI_USER}@${KALI_IP}" <<EOF
  nmap -sS ${MAIL_SRVNET}
  nmap --script vuln ${MAIL_SRVNET}
  nc -zv ${ROCKY_SRVNET} 22
  nc -zv ${ROCKY_SRVNET} 389
  nc -zv ${MAIL_SRVNET} 25
  ping -c 3 ${MAIL_SRVNET}
EOF
