#!/bin/bash
set -e
source "$(dirname "$0")/config.sh"

echo "[lab] Starting VMs..."
for vm in "$SENSOR_VM" "$ROCKY_VM" "$MAIL_VM" "$KALI_VM"; do
  if VBoxManage list runningvms | grep -q "\"$vm\""; then
    echo "  $vm already running"
  else
    VBoxManage startvm "$vm" --type headless >/dev/null
    echo "  $vm started"
  fi
done

echo "[lab] Waiting ${BOOT_WAIT}s for boot..."
sleep "$BOOT_WAIT"

echo "[lab] Configuring sensor..."
ssh "${SENSOR_USER}@${SENSOR_IP}" <<'EOF'
  sysctl -w net.ipv4.ip_forward=1 >/dev/null
  systemctl restart isc-dhcp-relay
  systemctl restart suricata
EOF

echo "[lab] System ready."
