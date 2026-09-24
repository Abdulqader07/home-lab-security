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
ssh -o LogLevel=ERROR "${SENSOR_USER}@${SENSOR_IP}" "tail -10 ${SURICATA_LOG} 2>/dev/null" | sed 's/^/  /'
echo ""

# --- Alert counts ---
echo "[2/3] Alert summary:"
echo "-----------------------------------------------"
for rule in "SMTP from outside" \
            "SSH from outside" \
            "LDAP from outside" \
            "IMAP from outside" \
            "ICMP to"; do
  COUNT=$(ssh -o LogLevel=ERROR "${SENSOR_USER}@${SENSOR_IP}" "grep -c '$rule' ${SURICATA_LOG} 2>/dev/null" | tail -1 | tr -d '[:space:]')
  COUNT=${COUNT:-0}
  if [ "$COUNT" -gt 0 ] 2>/dev/null; then
    echo "  ✓ $rule: $COUNT alerts"
  else
    echo "  ✗ $rule: not fired"
  fi
done
echo ""

# --- Mail verification ---
echo "[3/3] Mail in sara's inbox:"
echo "-----------------------------------------------"
COUNT=$(ssh -o LogLevel=ERROR "${MAIL_USER}@${MAIL_IP}" "find ${MAIL_INBOX_CUR} ${MAIL_INBOX_NEW} -type f 2>/dev/null | wc -l" | tail -1 | tr -d '[:space:]')
COUNT=${COUNT:-0}
if [ "$COUNT" -gt 0 ] 2>/dev/null; then
  echo "  ✓ $COUNT message(s) found"
  echo ""
  echo "  Recent messages:"
  ssh -o LogLevel=ERROR "${MAIL_USER}@${MAIL_IP}" "ls -la ${MAIL_INBOX_CUR} ${MAIL_INBOX_NEW} 2>/dev/null" | sed 's/^/    /'
else
  echo "  ✗ no messages"
fi
echo ""

echo "==============================================="
echo "  VERIFICATION COMPLETE"
echo "==============================================="
