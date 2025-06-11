## Segment 1: Analyzing Networks 
**Key Tools**: ifconfig (legacy) → ip command (modern)
1. **Legacy Tool**: ifconfig (Interface Configuration)
Purpose: Displays and configures network interfaces (IP, MAC, MTU, etc.).

```bash
Usage Example:
ifconfig      # Show all active interfaces
ifconfig -a   # Show all interfaces (including inactive)
ifconfig eth0 up/down   # Enable/disable an interface
ifconfig eth0 192.168.1.10 netmask 255.255.255.0  # Assign IP manually
```


**Limitations**:
Deprecated in many Linux distros (replaced by ip).
Less detailed than ip (e.g., no support for advanced routing).
2. **Modern Tool**: ip (from iproute2 package)
Purpose: More powerful replacement for ifconfig, route, and arp.

**Key Subcommands:**
ip link: Manage network interfaces (MAC, state, MTU).

```bash 
ip link show          # List all interfaces
ip link set eth0 up  # Enable interface

ip addr: Configure IP addresses.
ip addr show           # Show all IP addresses
ip addr add 192.168.1.10/24 dev eth0  # Assign IP
ip addr del 192.168.1.10/24 dev eth0  # Remove IP
sudo ip addr del 192.168.163.150/24 dev eth0

ip route: Manage routing tables

ip route show        # Display routing table
ip route add default via 192.168.1.1  # Set default gateway


ip neigh: Manage ARP cache (neighbor tables)
ip neigh show       # Show ARP table
ip neigh flush dev eth0  # Clear ARP entries for eth0


Advantages over ifconfig:
Supports IPv6 natively.
More granular control (e.g., multiple IPs per interface).
Integrates routing/ARP management.
3. Practical Use Cases
Check Network Status:
ip a   # Quick summary of interfaces and Ips
```


**Troubleshoot Connectivity:**
```bash
ip route get 8.8.8.8  # Show path to a destination
```


**Replace ifconfig Completely:**
```bash
alias ifconfig='ip a'  # For users accustomed to ifconfig
```

**4. Transition Tips**
Old (ifconfig) → New (ip)
```bash 
ifconfig eth0 up → ip link set eth0 up
ifconfig eth0 192.168.1.10 → ip addr add 192.168.1.10/24 dev eth0
netstat -r → ip route show
```

5. **Additional Tools**
**ss (Socket Statistics)**: Replaces netstat for monitoring connections.
ethtool: Query/modify NIC settings (speed, duplex).


**Conclusion:** Use ip for modern Linux systems; ifconfig is outdated but may still be present for compatibility.