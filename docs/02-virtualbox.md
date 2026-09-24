# VirtualBox Setup

## VMs

| OS | vCPU | vRAM | vDisk | Purpose |
|---|---|---|---|---|
| Rocky Linux | 2 | 2048 MB | 20 GB | DHCP, DNS, LDAP |
| Debian (Sensor) | 2 | 2048 MB | 20 GB | Routing, Suricata |
| Debian (Mail) | 1 | 1024 MB | 10 GB | Postfix, Dovecot |
| Kali Linux | 2 | 1544 MB | 10 GB | Attacker, DHCP client |

## Networks

| Name | Subnet | Type |
|---|---|---|
| idsnet | 192.168.10.0/24 | Internal |
| srvnet | 192.168.20.0/24 | Internal |
| intnet | 192.168.30.0/24 | Internal |

## Adapters

### Sensor
| Adapter | Type | IP |
|---|---|---|
| 1 | Bridged | DHCP |
| 2 | intnet | 192.168.30.1 |
| 3 | srvnet | 192.168.20.1 |
| 4 | idsnet | 192.168.10.1 |

### Rocky
| Adapter | Type | IP |
|---|---|---|
| 1 | Bridged | DHCP |
| 2 | srvnet | 192.168.20.2 |

### Mail
| Adapter | Type | IP |
|---|---|---|
| 1 | Bridged | DHCP |
| 2 | srvnet | 192.168.20.3 |

### Kali
| Adapter | Type | IP |
|---|---|---|
| 1 | Bridged | DHCP |
| 2 | intnet | DHCP |

## Notes

Bridged IPs change between locations. Internal network addresses
(192.168.10.x / 20.x / 30.x) are stable.
