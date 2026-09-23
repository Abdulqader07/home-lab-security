#!/bin/bash
set -e
source "$(dirname "$0")/config.sh"

echo "[verify] Suricata alerts:"
ssh "${SENSOR_USER}@${SENSOR_IP}" "tail -20 ${SURICATA_LOG}"

echo "[verify] Mail in sara's inbox:"
ssh "${MAIL_USER}@${MAIL_IP}" "ls -la ${MAIL_USER_MAILDIR}/new ${MAIL_USER_MAILDIR}/cur"
