#!/bin/bash
source "$(dirname "$0")/config.sh"

for vm in "$KALI_VM" "$MAIL_VM" "$ROCKY_VM" "$SENSOR_VM"; do
  echo "[lab] Stopping $vm..."
  VBoxManage controlvm "$vm" acpipowerbutton 2>/dev/null || true
done
