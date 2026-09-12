# Wireshark  
## Network Analysis and Attack Simulation Report

**Date:** September 10, 2026  
**Analyst:** Debika Goswami  

**Target Server:** Metasploitable 2  
**Target IP Address:** `192.168.23.130`  

**Analysis/Testing Platform:** Kali Linux  
**Virtualization Platform:** VMware  

---

# 1. Objective

The objective of this laboratory exercise was to use Wireshark to capture and analyze network traffic between Kali Linux and the intentionally vulnerable **Metasploitable 2** target server.

The exercise focused on:

1. Capturing and analyzing common network protocols such as DNS, HTTP, and FTP.
2. Identifying the security risks associated with unencrypted network protocols.
3. Analyzing FTP traffic and demonstrating the potential exposure of authentication information transmitted over an unencrypted control channel.
4. Simulating a controlled TCP SYN flood against the Metasploitable 2 server.
5. Identifying the characteristics of the simulated DoS traffic using Wireshark.
6. Developing practical packet-analysis skills relevant to network security monitoring and incident response.

> **Scope and Safety:** All activities described in this report were conducted in an authorized, isolated VMware laboratory environment. Metasploitable 2 was intentionally deployed as the vulnerable target system. No unauthorized external systems were targeted.

---

# 2. Laboratory Environment

The laboratory consisted of a Kali Linux virtual machine and a Metasploitable 2 virtual machine connected through the VMware virtual network.

### 2.1 Network Topology

```text
                 VMware Isolated Network
                         |
             192.168.23.0/24
                         |
          +--------------+--------------+
          |                             |
          |                             |
   Kali Linux VM                 Metasploitable 2
   Analysis Machine              Target Server
   Attacker/Analyst              Vulnerable Server
                                  IP: 192.168.23.130
          |
       Wireshark
          |
   Packet Capture &
    Traffic Analysis
```

### 2.2 Systems Used

| System | Role | IP Address |
|---|---|---|
| Kali Linux | Network analysis and traffic-generation system | `<Kali-IP>` |
| Metasploitable 2 | Target/vulnerable server | `192.168.23.130` |
| VMware | Virtualization and isolated networking platform | — |
| Wireshark | Packet capture and analysis | Kali Linux |
| hping3 | Controlled TCP traffic-generation tool | Kali Linux |

The Kali Linux IP address should be replaced with the **actual IP address observed in the laboratory**.

---

# 3. Tools Used

## 3.1 Wireshark

Wireshark was used to capture and analyze packets exchanged between Kali Linux and Metasploitable 2.

It provided visibility into:

- Source and destination IP addresses
- TCP and UDP ports
- TCP flags
- DNS queries and responses
- HTTP requests and responses
- FTP commands
- TCP connection behavior
- SYN flood traffic characteristics

## 3.2 hping3

`hping3` was used to generate controlled TCP SYN traffic against the Metasploitable 2 server.

The tool was used only within the authorized virtual laboratory.

## 3.3 Kali Linux

Kali Linux served as the primary security-analysis workstation. Wireshark and hping3 were operated from this system.

## 3.4 Metasploitable 2

Metasploitable 2 was used as the intentionally vulnerable target server.

The target IP address used throughout the exercise was:

**`192.168.23.130`**

---

# 4. Methodology

The exercise was divided into three phases:

### Phase 1
Basic protocol capture and filtering

### Phase 2
FTP plaintext credential analysis

### Phase 3
TCP SYN flood simulation and analysis against Metasploitable 2

Each phase was performed in the isolated VMware environment.

---

# 5. Phase 1 — Basic Protocol Capture and Filtering

## 5.1 Capture Initiation

Wireshark was launched on Kali Linux and the network interface connected to the VMware laboratory network was selected.

A live packet capture was initiated before generating network traffic.

The capture was intended to observe communications between Kali Linux and Metasploitable 2.

---

## 5.2 Connectivity Verification

Before beginning protocol analysis, connectivity between Kali Linux and Metasploitable 2 was verified.

The target server was:

```text
192.168.23.130
```

A basic connectivity test was performed from Kali Linux.

The response confirmed that the target was reachable through the laboratory network.

The Wireshark capture was then examined to identify the corresponding ICMP packets.

---

# 6. DNS and HTTP Traffic Analysis

## 6.1 DNS Traffic

DNS traffic was generated through normal name-resolution activity.

The following Wireshark display filter was used:

```text
dns
```

The resulting packets were inspected for:

- DNS queries
- DNS responses
- Requested domain names
- Resolved IP addresses
- Query/response relationships

DNS analysis demonstrated how domain names are translated into IP addresses through the DNS protocol.

> **Note:** DNS traffic may not appear for every browser request if the domain information is already cached. Therefore, the report should document only DNS packets actually observed in the capture.

---

## 6.2 HTTP Traffic

HTTP traffic associated with the laboratory environment was captured and examined using:

```text
http
```

Where HTTP services were available on Metasploitable 2, the target server's web services were used for analysis.

The packet capture was examined for:

- HTTP GET requests
- HTTP response codes
- Requested resources
- Host information
- HTTP headers
- Server responses

Because traditional HTTP does not encrypt application-layer traffic, information contained in HTTP requests and responses can potentially be viewed directly through packet capture.

---

# 7. Phase 2 — FTP Credential Analysis

## 7.1 Objective

The objective of this phase was to demonstrate the security weakness of traditional FTP when authentication information is transmitted without encryption.

Metasploitable 2 provides intentionally vulnerable network services, making it suitable for controlled protocol-security analysis.

---

## 7.2 FTP Traffic Capture

An FTP connection was established with the Metasploitable 2 server:

```text
Target: 192.168.23.130
Protocol: FTP
Port: 21
```

Wireshark was used to capture the FTP communication.

The following display filter was applied:

```text
ftp
```

The resulting packets were inspected for FTP commands and server responses.

---

## 7.3 FTP Authentication Analysis

The FTP authentication sequence was examined for commands such as:

```text
USER
PASS
```

A relevant FTP packet was selected and the following Wireshark function was used:

**Right-click → Follow → TCP Stream**

This reconstructed the TCP conversation and displayed the FTP control-channel communication as a continuous stream.

---

## 7.4 Findings

The analysis demonstrated the security weakness of conventional FTP.

FTP control traffic is not inherently encrypted. Consequently, authentication information transmitted through the control channel can potentially be exposed to an attacker who is capable of capturing the network traffic.

If the captured Metasploitable 2 FTP session contains readable `USER` and `PASS` commands, this provides direct packet-level evidence that the authentication information was transmitted in plaintext.

### Security Impact

An attacker with network-capture capability could potentially obtain FTP credentials and use them to access the associated service.

This demonstrates why plaintext authentication protocols should not be used for sensitive communications.

### Recommended Secure Alternatives

Secure file-transfer alternatives include:

- SFTP
- FTPS

The appropriate solution depends on the organization's infrastructure and security requirements.

---

# 8. Phase 3 — TCP SYN Flood Simulation

## 8.1 Objective

The objective of this phase was to conduct a controlled TCP SYN flood simulation against the Metasploitable 2 server and identify the resulting traffic pattern in Wireshark.

The designated target was:

```text
Metasploitable 2
IP Address: 192.168.23.130
```

---

# 9. Wireshark Configuration

A new Wireshark capture was initiated on the Kali Linux interface connected to the VMware laboratory network.

The following display filter was applied:

```text
tcp.flags.syn == 1 and tcp.flags.ack == 0
```

This filter displays TCP packets in which:

- SYN = 1
- ACK = 0

These characteristics correspond to initial TCP connection requests.

---

# 10. SYN Flood Simulation

The `hping3` utility was used from Kali Linux to generate TCP SYN traffic toward Metasploitable 2.

The laboratory command used was:

```bash
sudo hping3 -S --flood -V 192.168.23.130
```

The command directed the generated TCP SYN traffic toward the designated Metasploitable 2 server.

The test was performed only within the authorized VMware laboratory.

---

# 11. Wireshark Analysis of SYN Flood Traffic

Following execution of the controlled traffic-generation test, the Wireshark capture was examined.

## 11.1 High Volume of SYN Packets

The packet list showed a high volume of TCP packets containing the SYN flag.

The filter:

```text
tcp.flags.syn == 1 and tcp.flags.ack == 0
```

allowed the SYN traffic to be isolated from unrelated network packets.

This provided a clear view of the connection-request traffic directed toward Metasploitable 2.

---

## 11.2 Destination IP Analysis

The captured traffic was examined to verify the destination address.

The target destination was:

```text
192.168.23.130
```

A concentration of SYN packets toward this single destination is consistent with the controlled SYN flood simulation.

---

## 11.3 TCP Three-Way Handshake

Normal TCP connection establishment uses a three-way handshake:

```text
Client                     Server

  SYN  -------------------->
       <-------------------- SYN/ACK
  ACK  -------------------->
```

During a SYN flood, the target receives a large number of SYN requests.

The defender can therefore examine the relationship between:

- SYN packets
- SYN/ACK responses
- ACK packets
- completed TCP connections

A large number of SYN requests with relatively few completed handshakes can be an indicator of SYN-flood activity.

---

# 12. Source IP Address Analysis

The source IP addresses in the Wireshark capture were examined separately.

It is important not to automatically classify different source addresses as spoofed addresses.

### Correct interpretation

If the captured packets show a single Kali Linux source address, the report should state:

> "The captured SYN packets originated from the Kali Linux laboratory system and were directed toward Metasploitable 2."

If the capture actually shows multiple randomized or invalid source addresses, the report may document this as evidence consistent with source-address spoofing.

Therefore, the final report should use the **actual source addresses visible in the Wireshark evidence**.

This distinction is important because the `hping3` command shown above does not, by itself, prove that source-address spoofing occurred.

---

# 13. Key Findings

The exercise produced the following principal findings.

| Finding | Observation | Security Significance |
|---|---|---|
| DNS visibility | DNS queries/responses could be identified | Demonstrates domain-resolution traffic |
| HTTP visibility | HTTP requests/responses were readable where observed | Unencrypted HTTP can expose application data |
| FTP plaintext communication | FTP control traffic could be inspected | Credentials may be exposed if transmitted through plaintext FTP |
| SYN flood traffic | High volume of SYN packets observed | Indicates abnormal TCP connection-request activity |
| Target concentration | SYN traffic was directed toward `192.168.23.130` | Consistent with a targeted DoS simulation |
| Handshake analysis | TCP SYN/SYN-ACK/ACK behavior could be examined | Useful for detecting incomplete TCP connections |

---

# 14. Security Analysis

## 14.1 Risk of Unencrypted Protocols

The HTTP and FTP exercises demonstrated the risks associated with protocols that do not provide adequate encryption.

Network traffic captured by an unauthorized observer may expose:

- Authentication information
- Application requests
- Server responses
- Session information
- Other sensitive data

Encryption should therefore be used whenever sensitive information is transmitted across a network.

---

## 14.2 FTP Security

The FTP exercise demonstrated why traditional FTP should not be used to transmit sensitive credentials across untrusted networks.

The use of SFTP or FTPS provides stronger protection by encrypting the relevant communication.

---

## 14.3 SYN Flood Security

A SYN flood attempts to create a large number of TCP connection requests.

Potential effects can include:

- Increased resource consumption
- Growth of incomplete connection states
- Increased network traffic
- Reduced service availability
- Potential service degradation

The actual impact depends on the target's operating system, network configuration, available resources, and defensive controls.

---

# 15. Defensive Measures

The exercise also demonstrates several defensive practices.

## 15.1 Protecting Authentication Traffic

Organizations should:

- Avoid plaintext FTP for sensitive transfers.
- Use SFTP or FTPS.
- Prefer HTTPS instead of HTTP.
- Encrypt sensitive authentication traffic.
- Use strong authentication mechanisms.

## 15.2 Detecting SYN Floods

Network defenders can monitor:

- TCP SYN packet rates
- SYN-to-SYN/ACK ratios
- Incomplete TCP connections
- Unusual source-address patterns
- Concentrated traffic toward a particular server
- Sudden increases in connection attempts

## 15.3 Mitigation Techniques

Possible SYN-flood mitigation mechanisms include:

- Firewall filtering
- Connection-rate limiting
- SYN cookies
- Intrusion Detection/Prevention Systems
- DDoS protection
- Network traffic filtering
- Appropriate access-control policies

The appropriate defensive strategy should be selected according to the organization's architecture and threat model.

---



# 16. Conclusion

This laboratory exercise successfully demonstrated the use of Wireshark for network traffic capture, protocol analysis, and controlled security testing against a Metasploitable 2 target server.

The DNS and HTTP analysis provided practical experience in identifying network and application-layer communications. The FTP analysis demonstrated the security risks associated with plaintext protocols and showed how packet capture can potentially expose authentication information transmitted through an unencrypted FTP control channel.

The controlled TCP SYN flood simulation against Metasploitable 2 demonstrated how abnormal TCP connection-request traffic can be identified through packet analysis. The Wireshark filter:

```text
tcp.flags.syn == 1 and tcp.flags.ack == 0
```

provided an effective method for isolating initial TCP SYN packets and observing the resulting traffic pattern.

The exercise also emphasized an important principle of security analysis: **conclusions must be supported by observable evidence**. For example, source-address spoofing should only be reported when the packet capture provides evidence of spoofed or randomized source addresses.

Overall, the laboratory demonstrated how Wireshark can provide valuable packet-level visibility for:

- Network troubleshooting
- Protocol analysis
- Vulnerability assessment
- Attack detection
- Incident investigation
- Security monitoring

The exercise reinforces the importance of encrypted communication protocols, network monitoring, and appropriate defensive controls for protecting network services against credential exposure and denial-of-service attacks.

---
