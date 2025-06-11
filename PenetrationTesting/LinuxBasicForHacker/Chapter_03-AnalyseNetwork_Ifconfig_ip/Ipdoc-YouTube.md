# Python Script To Test IP

```bash
#!/usr/bin/env python3
import netifaces
import sys
from datetime import datetime

def get_mac_address(interface):
    """Get the MAC address of a network interface with error handling"""
    try:
        with open(f'/sys/class/net/{interface}/address') as f:
            return f.read().strip()
    except IOError as e:
        print(f"\n⚠️  Error reading MAC address for {interface}: {str(e)}", file=sys.stderr)
        return "00:00:00:00:00:00"
    except Exception as e:
        print(f"\n⚠️  Unexpected error getting MAC address: {str(e)}", file=sys.stderr)
        return "00:00:00:00:00:00"

def get_ip_address(interface):
    """Get the IP address of a network interface with error handling"""
    try:
        return netifaces.ifaddresses(interface)[netifaces.AF_INET][0]['addr']
    except (ValueError, KeyError) as e:
        print(f"\n⚠️  No IP address assigned to {interface} or interface not active", file=sys.stderr)
        return "0.0.0.0"
    except Exception as e:
        print(f"\n⚠️  Unexpected error getting IP address: {str(e)}", file=sys.stderr)
        return "0.0.0.0"

def display_network_interfaces():
    """Display available network interfaces with error handling"""
    try:
        interfaces = netifaces.interfaces()
        active_interfaces = []
        
        print("\nAvailable network interfaces:")
        for i, iface in enumerate(interfaces):
            if iface != 'lo':  # Skip loopback
                try:
                    mac = get_mac_address(iface)
                    ip = get_ip_address(iface)
                    print(f"{i+1}. {iface} - Current IP: {ip}, MAC: {mac}")
                    active_interfaces.append(iface)
                except Exception as e:
                    print(f"{i+1}. {iface} - Error reading details: {str(e)}")
                    continue
        
        if not active_interfaces:
            print("\n❌ No active network interfaces found!")
            return None
        
        return active_interfaces
    
    except Exception as e:
        print(f"\n⚠️  Critical error listing interfaces: {str(e)}", file=sys.stderr)
        return None

def simulate_access_point():
    """Main function to simulate the access point with whitelisting"""
    try:
        # Define authorized credentials
        AUTHORIZED_IPS = {
            "192.168.70.80": "Admin Device",
            "192.168.70.81": "Printer",
            "192.168.70.100": "Security Camera",
            "192.168.70.150": "IoT Device"
        }
        
        AUTHORIZED_MAC = "00:1A:2B:3C:4D:5E"  # Hypothetical authorized MAC
        
        print("\n=== WiFi Access Point Simulator with IP Whitelisting ===")
        print(f"Authorized IPs: {', '.join(AUTHORIZED_IPS.keys())}")
        print(f"Authorized MAC: {AUTHORIZED_MAC}\n")
        
        # Display interfaces and handle errors
        active_interfaces = display_network_interfaces()
        if not active_interfaces:
            raise RuntimeError("No usable network interfaces available")
        
        # Let user select interface to "connect"
        try:
            choice = input("\nSelect interface to connect (1-{} or 'q' to quit): ".format(len(active_interfaces)))
            if choice.lower() == 'q':
                print("\n🛑 User requested exit. Shutting down...")
                return
            
            choice = int(choice) - 1
            if choice < 0 or choice >= len(active_interfaces):
                raise ValueError("Invalid selection")
            
            selected_iface = active_interfaces[choice]
        except ValueError as e:
            print(f"\n⚠️  Invalid selection: {str(e)}", file=sys.stderr)
            print("Using first available interface as default.")
            selected_iface = active_interfaces[0]
        
        # Get connection details
        mac = get_mac_address(selected_iface)
        current_ip = get_ip_address(selected_iface)
        
        # Let user test different IPs
        print("\n=== Connection Simulation ===")
        test_ip = input(f"Enter IP to test (current {current_ip} or 'q' to quit): ").strip()
        
        if test_ip.lower() == 'q':
            print("\n🛑 User requested exit. Shutting down...")
            return
        
        test_ip = test_ip or current_ip
        
        # Validate IP format
        try:
            socket.inet_aton(test_ip)  # Validate IP address format
        except socket.error:
            print(f"\n⚠️  Invalid IP address format: {test_ip}", file=sys.stderr)
            print("Using current IP address instead.")
            test_ip = current_ip
        
        # Simulate connection
        print("\n=== Connection Attempt ===")
        print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"Interface: {selected_iface}")
        print(f"MAC Address: {mac}")
        print(f"IP Address: {test_ip}")
        
        # Perform authorization checks
        print("\n=== Authorization Checks ===")
        
        # IP Whitelist Check
        ip_check = test_ip in AUTHORIZED_IPS
        device_name = AUTHORIZED_IPS.get(test_ip, "Unauthorized Device")
        print(f"\nIP Whitelist Check: {'✅ SUCCESS' if ip_check else '❌ FAILED'}")
        print(f"Device Identity: {device_name}")
        print(f"Your IP: {test_ip}")
        print(f"Authorized IPs: {', '.join(AUTHORIZED_IPS.keys())}")
        
        # MAC Check
        mac_check = mac.lower() == AUTHORIZED_MAC.lower()
        print(f"\nMAC Check ({AUTHORIZED_MAC}): {'✅ SUCCESS' if mac_check else '❌ FAILED'}")
        print(f"Your MAC: {mac}")
        
        # Combined result
        if ip_check and mac_check:
            print("\n🎉 FULL AUTHORIZATION: Connection successful!")
            print("Both IP and MAC address are authorized.")
        elif ip_check:
            print("\n⚠️  PARTIAL AUTHORIZATION: IP is whitelisted but MAC doesn't match")
            print("Some networks might allow this with MAC filtering disabled")
        elif mac_check:
            print("\n⚠️  PARTIAL AUTHORIZATION: MAC matches but IP not whitelisted")
            print("This might work in networks using only MAC filtering")
        else:
            print("\n❌ AUTHORIZATION FAILED: Connection rejected!")
            print("Neither IP nor MAC address are authorized.")
        
        print("\n=== Demonstration Complete ===")
    
    except KeyboardInterrupt:
        print("\n🛑 Keyboard interrupt received. Shutting down gracefully...")
    except Exception as e:
        print(f"\n⚠️  An unexpected error occurred: {str(e)}", file=sys.stderr)
    finally:
        print("\n🔌 Access point simulator terminated cleanly.\n")
        sys.exit(0)

if __name__ == "__main__":
    # Import socket here to avoid top-level import error if netifaces fails
    import socket
    simulate_access_point()
```
# *Check the video to see how to use it.*