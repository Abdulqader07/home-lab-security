#!/bin/bash
# Central config — edit this when IPs change

# VM names in VirtualBox
SENSOR_VM="Debian Sensor"
ROCKY_VM="Rocky Linux Server"
MAIL_VM="Mail Server"
KALI_VM="kali-linux-2026.2-virtualbox-amd64"

# SSH access (bridged IPs — change when you move)
SENSOR_IP="192.168.88.56"
ROCKY_IP="192.168.88.49"
MAIL_IP="192.168.88.117"
KALI_IP="192.168.88.134"

# SSH users
SENSOR_USER="root"
ROCKY_USER="root"
MAIL_USER="root"
KALI_USER="kali"

# Lab network addresses (never change)
SENSOR_SRVNET="192.168.20.1"
SENSOR_INTNET="192.168.30.1"
ROCKY_SRVNET="192.168.20.2"
MAIL_SRVNET="192.168.20.3"
KALI_INTNET="192.168.30.6"

# Paths
SURICATA_LOG="/var/log/suricata/fast.log"
MAIL_USER_MAILDIR="/home/sara/Maildir"

# Timeouts
BOOT_WAIT=30
