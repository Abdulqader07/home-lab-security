# Home Lab Security

A segmented homelab with a firewall/IDS between a servers farm and an
internal network.

## Architecture

| Host | Role | OS | IP |
|---|---|---|---|
| Firewall IDS | Routing, NAT, DHCP relay, Suricata | Debian | 192.168.10.1 / 192.168.20.1 / 192.168.30.1 |
| Rocky Linux Server | DHCP, DNS, LDAP | Rocky Linux | 192.168.20.2 |
| Mail Server | Postfix, Dovecot | Debian | 192.168.20.3 |
| Kali Linux | Attacker | Kali | 192.168.30.x (DHCP) |

## Networks

| Name | Subnet | Purpose |
|---|---|---|
| idsnet | 192.168.10.0/24 | Sensor ↔ host |
| srvnet | 192.168.20.0/24 | Servers farm |
| intnet | 192.168.30.0/24 | Internal clients |

## Quick Start

```bash
cd scripts
./lab-up.sh
./attack.sh
./verify.sh
./lab-down.sh


Docs

    Scenario

    VirtualBox Setup

    Rocky Linux Server

    Kea DHCP

    Unbound DNS

    LDAP

    Mail

    Sensor

    Suricata

    Automation

    Permissions


Layout

configs/    — configuration files from all VMs
docs/       — documentation
scripts/    — automation scripts
diagrams/   — topology
screenshots/— evidence




---

### `docs/01-scenario.md`

```markdown
# Scenario

A regional bank branch runs two servers:

- **Rocky Linux Server** — infrastructure (DHCP, DNS, LDAP)
- **Debian Mail Server** — internal email

A **Debian Sensor** sits at the network core, routing traffic between
three zones and silently monitoring every packet. **Kali Linux** plays
the attacker — probing the mail server, enumerating LDAP, injecting
traffic, attempting credential access.

The sensor detects every move. Suricata fires alerts. The bank
doesn't know it's under attack. The sensor does.

## What runs where

| Host | Role | OS |
|---|---|---|
| Firewall IDS | Routing, NAT, DHCP relay, Suricata | Debian |
| Rocky Linux Server | DHCP, DNS, LDAP | Rocky Linux |
| Mail Server | Postfix, Dovecot | Debian |
| Kali Linux | Attacker | Kali |

## Zones

| Network | Subnet | Purpose |
|---|---|---|
| idsnet | 192.168.10.0/24 | Sensor ↔ host |
| srvnet | 192.168.20.0/24 | Servers farm |
| intnet | 192.168.30.0/24 | Internal clients |
