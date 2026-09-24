# Automation

**Purpose:** Reproducible lab - one command to boot, attack, verify.

## Scripts

| Script | What it does |
|---|---|
| config.sh | Central config - IPs, users, paths |
| lab-up.sh | Boot VMs, configure sensor |
| attack.sh | Run attacks from Kali |
| verify.sh | Check Suricata alerts and mail delivery |
| lab-down.sh | Clean shutdown |

## Usage

```cd scripts
./lab-up.sh
./attack.sh
./verify.sh
./lab-down.sh```



## IP Management

Bridged management IPs change between locations. Edit
scripts/config.sh once; everything else reads from it:

```SENSOR_IP="20.20.20.39"
ROCKY_IP="20.20.20.37"
MAIL_IP="20.20.20.40"
KALI_IP="20.20.20.50"```



Internal lab IPs (192.168.10.x / 20.x / 30.x) never change.

## lab-up.sh steps

1. Checks each VM - starts if not running
2. Waits for boot
3. SSHs to the sensor and:
   - enables IP forwarding
   - restarts DHCP relay
   - restarts Suricata

## attack.sh steps

Runs from Kali:
- nmap port scan on mail server
- nmap vuln scan
- SSH / LDAP / SMTP probes
- ICMP ping
- Sends test mail via swaks

## verify.sh steps

1. Shows last 10 Suricata alerts
2. Counts alerts per rule - pass/fail
3. Checks sara's Maildir for messages

## Future Work

- Replace bridged adapters with Host-Only for stable management IPs
- Replace SSH heredocs with Ansible playbook
- Add log parsing for automatic pass/fail reporting
