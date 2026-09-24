# Debian Sensor

**Role:** Central router and IDS monitoring point.
**IPs:** 192.168.10.1 / 192.168.20.1 / 192.168.30.1

## Purpose

Routes traffic between three lab zones and monitors every packet.
Inline design - the sensor is both the router and the IDS.

## Interfaces

| Interface | Network | IP |
|---|---|---|
| enp0s3 | Bridged (management) | DHCP |
| enp0s8 | intnet | 192.168.30.1 |
| enp0s9 | srvnet | 192.168.20.1 |
| enp0s10 | idsnet | 192.168.10.1 |

## Routing

Enable IP forwarding:
