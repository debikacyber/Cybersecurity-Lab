# TASK-1_Foundation & Environment Setup
 Video link:https://lnkd.in/p/d-5PvJjU


A controlled, isolated cybersecurity practice environment using **Kali Linux**, **Metasploitable 2**, **VMware Workstation**, and **Wireshark**.

> **Safety:** Metasploitable 2 is intentionally vulnerable. Keep it on an isolated **Host-Only/Internal** virtual network and never expose it directly to an untrusted or production network.

---

## 1. Lab Overview

This repository documents the setup and verification of a virtual cybersecurity laboratory designed for hands-on learning and controlled security testing.

The environment provides a foundation for:

- Linux administration
- Network reconnaissance
- Service discovery
- Vulnerability assessment
- Controlled exploitation
- Network packet analysis
- Incident-analysis exercises

The lab consists of two virtual machines connected through an isolated virtual network:

| Component | Role |
|---|---|
| **Kali Linux** | Security testing workstation |
| **Metasploitable 2** | Intentionally vulnerable target VM |
| **VMware Workstation** | Virtualization platform |
| **Wireshark** | Network packet capture and analysis |

---

## 2. Lab Architecture

```text
                         HOST COMPUTER
                              |
                       VMware Workstation
                              |
                 Isolated Host-Only Network
                       192.168.23.0/24
                         /             \
                        /               \
                       v                 v
              +---------------+   +-------------------+
              |   Kali Linux  |   |  Metasploitable 2 |
              |    Attacker   |   |       Target      |
              | 192.168.23.129|   |  192.168.23.128   |
              +---------------+   +-------------------+
                       |
                       v
                  +-----------+
                  | Wireshark |
                  |  Capture  |
                  +-----------+
```

The topology documented in the lab report uses:

- **Kali Linux:** `192.168.23.129/24`
- **Metasploitable 2:** `192.168.23.128/24`

The lab report identifies the network as an isolated testing environment and specifically warns against exposing Metasploitable 2 to an untrusted or production network.

---

## 3. Objectives

The primary objectives of this lab are to:

1. Configure Kali Linux and Metasploitable 2 as virtual machines.
2. Connect both systems through an isolated virtual network.
3. Verify the operating system and network configuration.
4. Verify connectivity between Kali Linux and Metasploitable 2.
5. Perform basic service/network discovery in later exercises.
6. Capture and analyze test traffic using Wireshark.
7. Establish a controlled environment for subsequent cybersecurity practicals.

---

## 4. Prerequisites

### Software

- VMware Workstation
- Kali Linux virtual machine
- Metasploitable 2 virtual machine
- Wireshark

### Recommended Configuration

Both VMs should use the same isolated:

```text
Host-Only / Internal Network
```

Do **not** connect the intentionally vulnerable Metasploitable 2 VM directly to the Internet, corporate network, or another untrusted network.

---

## 5. Verify Kali Linux

Start the Kali Linux VM and open a terminal.

### 5.1 Verify Operating System

```bash
cat /etc/os-release
```

Expected identification includes:

```text
PRETTY_NAME="Kali GNU/Linux Rolling"
NAME="Kali GNU/Linux"
ID=kali
ID_LIKE=Debian
```

### 5.2 Check Kernel

```bash
uname -a
```

### 5.3 Check Current User

```bash
whoami
```

The lab report records the current user as:

```text
Student
```

### 5.4 Check IP Configuration

```bash
ip addr
```

or:

```bash
ip a
```

Expected lab address:

```text
192.168.23.129/24
```

---

## 6. Verify Metasploitable 2

Start the Metasploitable 2 VM and log in.

### 6.1 Identify the Network Interface

```bash
ifconfig
```

or:

```bash
ip addr
```

Expected lab address:

```text
192.168.23.128/24
```

### 6.2 Check Routing

```bash
route -n
```

or:

```bash
ip route
```

---

## 7. Verify Network Connectivity

From Kali Linux, test connectivity to Metasploitable 2:

```bash
ping -c 7 192.168.23.128
```

The documented lab test produced:

```text
7 packets transmitted, 7 received, 0% packet loss
```

with:

```text
rtt min/avg/max/mdev = 1.233/11.073/38.503/14.910 ms
```

This confirms basic network-layer connectivity between the two laboratory systems.

---

## 8. Wireshark Packet Capture

Wireshark is used to capture and analyze traffic generated inside the isolated lab.

### 8.1 Start Wireshark

```bash
wireshark
```

Select the network interface connected to the isolated laboratory network and start a capture.

### 8.2 Generate ICMP Traffic

From the Kali terminal:

```bash
ping -c 7 192.168.23.128
```

### 8.3 Apply the Display Filter

In Wireshark, use:

```text
icmp
```

The capture should show ICMP:

- Echo Request packets
- Echo Reply packets

### 8.4 Save the Capture

Save the packet capture as:

```text
task1_wireshark_test_capture.pcapng
```

---

The accompanying lab report contains screenshots documenting the VM setup, Kali configuration, Metasploitable 2 configuration, connectivity test, and Wireshark capture.

---

## 11. Learning Workflow

The lab is intended to progress from environment validation to controlled security testing:

```text
Lab Setup
    ↓
VM Configuration
    ↓
Network Verification
    ↓
Connectivity Testing
    ↓
Wireshark Packet Capture
    ↓
Reconnaissance
    ↓
Service Discovery
    ↓
Vulnerability Assessment
    ↓
Controlled Exploitation
    ↓
Evidence Collection
    ↓
Incident Analysis
    ↓
Remediation
```

Only perform security testing against systems that are intentionally provided for the exercise or for which you have explicit authorization.

---

## 12. Key Commands

### Kali Linux

```bash
cat /etc/os-release
uname -a
whoami
ip addr
ip route
ping -c 7 192.168.23.128
wireshark
```

### Metasploitable 2

```bash
ifconfig
ip addr
route -n
ip route
```

### Wireshark

Display filter:

```text
icmp
```

---

## 13. Troubleshooting

### Kali cannot reach Metasploitable 2

Check:

```bash
ip addr
ip route
```

Confirm that both systems are connected to the same isolated virtual network and that the expected addresses are assigned:

```text
Kali:          192.168.23.129/24
Metasploitable:192.168.23.128/24
```

Then retry:

```bash
ping -c 7 192.168.23.128
```

### Wireshark does not show ICMP packets

Verify that:

1. The correct virtual network interface is selected.
2. Packet capture has been started before generating traffic.
3. Kali is actually communicating with `192.168.23.128`.
4. The display filter is:

```text
icmp
```

---

## 14. Expected Outcome

After completing the setup:

- Kali Linux should be available as the security-testing workstation.
- Metasploitable 2 should be reachable only through the isolated lab network.
- Kali should successfully communicate with Metasploitable 2.
- Wireshark should capture the generated ICMP traffic.
- The environment should be ready for subsequent cybersecurity practical exercises.

---

## 15. Responsible Use

This repository is intended for **educational and authorized cybersecurity testing**.

Metasploitable 2 is deliberately vulnerable and should be treated as an unsafe system. Keep the VM isolated and use the environment only for controlled laboratory exercises.

Do not use the techniques, tools, or procedures documented in this repository against systems without appropriate authorization.

---

## 16. Author

**Student:** Debika Goswami  
**Course:** Cybersecurity & Ethical Hacking Internship Program  
**Lab:** Cybersecurity Practical Lab

---

## License

This repository is intended for educational and training purposes. Add an appropriate license if the repository will contain original code or other material intended for reuse.

