# Scenario

A regional bank branch runs two servers:

- **Rocky Linux Server** - infrastructure (DHCP, DNS, LDAP)
- **Debian Mail Server** - internal email

A **Debian Sensor** sits at the network core, routing traffic between
three zones and silently monitoring every packet. **Kali Linux** plays
the attacker - probing the mail server, enumerating LDAP, injecting
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
| idsnet | 192.168.10.0/24 | Sensor to host |
| srvnet | 192.168.20.0/24 | Servers farm |
| intnet | 192.168.30.0/24 | Internal clients |
