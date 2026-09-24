# Rocky Linux Server

Central infrastructure server.

**IP:** 192.168.20.2 (srvnet)

## Services

| Service | Software | Purpose |
|---|---|---|
| DHCP | Kea | Assign IPs to intnet clients |
| DNS | Unbound | Resolve internal + forward external |
| LDAP | 389 Directory Server | Central user directory |

## Network

- Adapter 1 (bridged) — management, internet
- Adapter 2 (srvnet) — 192.168.20.2

## Sub-docs

- [Kea DHCP](03.1-kea-dhcp.md)
- [Unbound DNS](03.2-unbound-dns.md)
- [LDAP](03.3-ldap.md)
