# File Permissions and Ownership

Git does not track ownership or permission bits (except the executable
flag). After cloning and copying configs to fresh VMs, apply these.

## Mail Server

### Postfix LDAP map

```sudo chown root:root /etc/postfix/ldap-mailbox.cf
sudo chmod 644 /etc/postfix/ldap-mailbox.cf```


### User Maildirs

```for u in ali sara; do
sudo mkdir -p /home/u/Maildir/cur,new,tmpsudochown−R10001:10001/home/u/Maildir/cur,new,tmpsudochown−R10001:10001/home/u
sudo chmod -R 700 /home/$u
done```


## Sensor

```sudo chown root:root /etc/suricata/rules/local.rules
sudo chmod 644 /etc/suricata/rules/local.rules

sudo chown root:root /etc/network/interfaces
sudo chmod 644 /etc/network/interfaces

sudo chown root:root /etc/nftables.conf
sudo chmod 644 /etc/nftables.conf```


## Rocky Linux Server

```chmod 600 /root/*.ldif```


## Kali

```sudo chown root:root /etc/NetworkManager/system-connections/.nmconnection
sudo chmod 600 /etc/NetworkManager/system-connections/.nmconnection```


## Why 10001

Mail uses a single UID for all delivery
(virtual_uid_maps = static:10001). Every Maildir must be owned by
that UID, otherwise Postfix logs:

```maildir delivery failed: Permission denied```


## Why 644 / 600 / 700

| Mode | Meaning |
|---|---|
| 644 | readable by service, not writable |
| 600 | contains secrets (SSH keys, WiFi passwords) |
| 700 | directory accessible only by owner |

Postfix and SSH refuse group- or world-writable config files:

```warning: group or other writable: /etc/postfix/ldap-mailbox.cf
fatal: maildir delivery failed: Permission denied```
