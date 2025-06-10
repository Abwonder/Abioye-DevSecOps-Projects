# Advanced Networking with the `ip` Command  
*A modern replacement for `ifconfig`, `route`, and `arp`.*  

🔗 **GitHub Repository**: [Your-Repo-Link](#) *(Replace with your actual GitHub link)*  

---

## 1. Advanced Interface Management (`ip link`)  

### View Detailed Interface Info  

```bash
ip -s link show eth0  # Stats (packets, errors, drops)
```

**ip -s**: Show statistics (packets, errors, drops)
**link**: Work with network interfaces
**show eth0**: Display info for the eth0 interface
**Example output**: Shows bytes transferred, errors, link state (UP/DOWN), MAC address

### Change MAC Address (Temporarily)

```bash
ip link set dev eth0 address 00:11:22:33:44:55
```
**set**: Modify interface settings
**dev eth0**: Specify the network device
**address**: Change the MAC address
**Note**: Change resets after reboot. For permanent change, edit /etc/network/interfaces

### Set MTU (Jumbo Frames, VPNs)

```bash
ip link set dev eth0 mtu 9000
```

mtu 9000: Set Maximum Transmission Unit size
When to use: For jumbo frames (high-speed networks) or VPN tuning
Typical values: 1500 (default), 9000 (jumbo frames)


## 2. Multiple IPs & Virtual Interfaces

Add Secondary IPs

```bash
ip addr add 192.168.1.20/24 dev eth0 label eth0:1
```

### Create VLAN Interfaces

```bash
ip link add link eth0 name eth0.100 type vlan id 100
ip addr add 192.168.100.1/24 dev eth0.100
ip link set eth0.100 up
```

## 3. Advanced Routing (ip route)

Policy-Based Routing (Multiple Tables)

```bash
# Add a custom routing table (e.g., table 100)
echo "100 custom_table" >> /etc/iproute2/rt_tables
ip route add 10.0.0.0/24 via 192.168.1.1 table custom_table
ip rule add from 192.168.1.10 lookup custom_table  # Force traffic from IP to use table
```

### Load Balancing (Multipath Routes)

```bash
ip route add default scope global nexthop via 192.168.1.1 dev eth0 weight 1 \
nexthop via 192.168.2.1 dev eth1 weight 1
```

## 4. Network Namespaces (Isolation)

Create/List Namespaces

```bash
ip netns add ns1
ip netns list
```

### Move Interface to Namespace

```bash
ip link set eth1 netns ns1
ip netns exec ns1 ip addr show  # Run commands inside ns1
```

## 5. Neighbor (ARP/NDP) Tricks (ip neigh)

Static ARP Entry
```bash
ip neigh add 192.168.1.100 lladdr 00:11:22:33:44:55 dev eth0 nud permanent
Flush Unreachable Entries
```

```bash
ip neigh flush all
```

## 6. Traffic Control (QoS)

View Interface Queues
```bash
tc qdisc show dev eth0
```

### Limit Bandwidth

```bash
tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms
```

## 7. Bridging (ip link + bridge)

Create a Software Bridge

```bash
ip link add name br0 type bridge
ip link set eth0 master br0
ip link set br0 up
```

## 8. Monitoring with ss (Socket Statistics)

Replace netstat -tulpn
```bash
ss -tulpn  # Show listening ports + processes
```

### Filter by State (e.g., ESTABLISHED)

```bash
ss -t state established
```

## 9. Real-World Scenarios

Diagnose Packet Drops

```bash
ip -s link show eth0 | grep drops
Force IPv6 Address
```

```bash
ip -6 addr add 2001:db8::1/64 dev eth0
Tunnel Setup (GRE Example)
bash
ip tunnel add gre1 mode gre remote 203.0.113.5 local 198.51.100.10 ttl 255
ip link set gre1 up
ip addr add 10.0.0.1/30 dev gre1
```

## 10. Scripting with ip

JSON Output (for automation)
```bash
ip -j addr show eth0 | jq .  # Requires `jq`
```

# Key Takeaways
ip > ifconfig: Far more granular control (VLANs, namespaces, policy routing)

#### *Think in Objects: link (L2), addr (L3), route (L3 forwarding)*

Combine Tools: Use ip + tc (QoS), ip + ss (monitoring)

❓ Need more? Explore:

[Linux iproute2 Official Docs](https://baturin.org/docs/iproute2/)

GitHub Repository (Add your repo link here)