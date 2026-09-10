Wireshark

What it is: Wireshark is a network protocol analyzer that lets you capture and analyze data packets traveling over a network.

How it works: It places your network interface into "promiscuous mode" to capture all network traffic, not just traffic addressed to your system.

Use cases: It's used for troubleshooting network problems, analyzing application behavior, and detecting security threats.

Key features:
Packet list: Shows all captured packets in real time.
Filters: You can use both capture filters (to limit what is recorded) and display filters (to focus on what you see after capturing).

Nmap

What it is: Nmap (Network Mapper) is a powerful tool used for network discovery and security auditing.

How it works: It sends specially crafted packets to a target and analyzes the responses to determine what hosts are available, what services they offer, and what operating system they are running.

Use cases: Creating a map of a computer network, detecting open ports, and auditing for vulnerabilities.

Key commands:
nmap [target] - Basic scan of a host.
nmap -sS - TCP SYN Scan (Stealth scan).
nmap -sV - Service Version detection.
nmap -p [port] - Scans a specific port or port range.

Burp Suite

What it is: Burp Suite is a web application penetration testing toolkit. Its core function is acting as an interception proxy.

How it works: It sits between your web browser and the internet, allowing you to intercept, view, and modify all HTTP and HTTPS requests and responses.

Use cases: Identifying web vulnerabilities like SQL injection and cross-site scripting (XSS), and manually testing a website's security.

Netcat

What it is: Netcat (nc) is a versatile command-line tool known as the "Swiss Army knife" for network security. It's used for reading from and writing to network connections.

How it works: It can act as a client (to connect to a port on a remote host) or a server (to listen for incoming connections).

Use cases: Port scanning, file transfer, creating backdoors, and simple network debugging.

Key options:
-v: Verbose mode (gives more details).
-z: Zero-I/O mode (used for scanning only, without sending data).
-l: Listen mode (waits for an incoming connection).
-p: Specifies the source port.