#!/bin/bash
set -e
source "$(dirname "$0")/config.sh"

echo "==============================================="
echo "  LAB VERIFICATION"
echo "==============================================="
echo ""

# --- Suricata alerts ---
echo "[1/3] Suricata alerts (last 10):"
echo "-----------------------------------------------"
ssh "${SENSOR_USER}@${SENSOR_IP}" "tail -10 ${SURICATA_LOG} 2>/dev/null" | sed 's/^/  /'
echo ""

# --- Alert counts ---
echo "[2/3] Alert summary:"
echo "-----------------------------------------------"
for rule in "SMTP from outside the servers farm" \
            "SSH from outside the servers farm" \
            "LDAP from outside the servers farm" \
            "IMAP from outside the servers farm" \
            "ICMP to servers farm"; do
  COUNT=$(ssh "${SENSOR_USER}@${SENSOR_IP}" "grep -c '$rule' ${SURICATA_LOG} 2>/dev/null || echo 0")
  if [ "$COUNT" -gt 0 ]; then
    echo "  ✓ $rule: $COUNT alerts"
  else
    echo "  ✗ $rule: not fired"
  fi
done
echo ""

# --- Mail verification ---
echo "[3/3] Mail in sara's inbox:"
echo "-----------------------------------------------"
COUNT=$(ssh "${MAIL_USER}@${MAIL_IP}" "ls ${MAIL_INBOX_CUR} ${MAIL_INBOX_NEW} 2>/dev/null | wc -l")
if [ "$COUNT" -gt 0 ]; then
  echo "  ✓ $COUNT message(s) found"
  echo ""
  echo "  Recent messages:"
  ssh "${MAIL_USER}@${MAIL_IP}" "ls -la ${MAIL_INBOX_CUR} ${MAIL_INBOX_NEW} 2>/dev/null" | sed 's/^/    /'
else
  echo "  ✗ no messages"
fi
echo ""

echo "==============================================="
echo "  VERIFICATION COMPLETE"
echo "==============================================="
