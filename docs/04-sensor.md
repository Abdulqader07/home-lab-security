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

```bash
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl --system
```

## NAT for internet access of lab VMs:

```bash
sudo nft add table ip nat
sudo nft add chain ip nat postrouting '{ type nat hook postrouting priority srcnat; policy accept; }'
sudo nft add rule ip nat postrouting oifname "enp0s3" masquerade
sudo nft list ruleset | sudo tee /etc/nftables.conf
sudo systemctl enable nftables
```

## DHCP Relay

Listens on intnet, forwards to Kea on Rocky.

/etc/default/isc-dhcp-relay:

```
SERVERS="192.168.20.2"
INTERFACES="enp0s8 enp0s9"
OPTIONS="-a"
```

```
sudo systemctl enable --now isc-dhcp-relay
```
