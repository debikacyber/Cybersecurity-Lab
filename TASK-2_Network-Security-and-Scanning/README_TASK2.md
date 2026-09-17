# TASK-2_Network-Security-and-Scanning
 ##Video link: https://www.linkedin.com/feed/update/urn:li:activity:7505530405102690305/

## Overview

This repository documents a controlled network reconnaissance and vulnerability assessment of **Metasploitable 2**, an intentionally vulnerable Linux virtual machine used for cybersecurity training.

The assessment was conducted from a **Kali Linux** scanner/attacker host over an **isolated VMware Host-Only network**. The work combines:

- **Nmap** network and service reconnaissance
- **Nessus** vulnerability assessment
- Service/version enumeration
- Vulnerability identification and severity classification
- Evidence correlation between Nmap and Nessus results
- Risk analysis and remediation recommendations

The assessment date recorded in both reports is **11-09-2026**.

> **Safety:** Metasploitable 2 is intentionally vulnerable. The reports describe an isolated lab environment. Do not expose this system to production, corporate, public, or otherwise untrusted networks.

---

## Assessment Scope

| Item | Nmap Report | Nessus Report |
|---|---|---|
| Target | Metasploitable 2 | Metasploitable 2 |
| Scanner | Kali Linux | Nessus / Tenable Nessus |
| Network | Host-Only VMware network | VMware Host-Only, isolated |
| Assessment Date | 11-09-2026 | 11-09-2026 |
| Target IP recorded | `192.168.23.128` in the report scope/executive summary; scan commands use `192.168.23.130` | `192.168.23.130` |
| Scanner IP | Not specified in the Nmap report scope | `192.168.23.129` |

### IP Address Note

The two supplied reports contain an **IP-address discrepancy**. The Nmap report identifies `192.168.23.128` as the target in its executive summary and scope, while its documented Nmap commands scan `192.168.23.130`. The Nessus report consistently identifies `192.168.23.130` as the target and `192.168.23.129` as the scanner.

This README intentionally preserves the information from the supplied reports rather than silently changing or reconciling it. Verify the actual VM IP before reproducing the scans.

---

## Assessment Workflow

```text
Metasploitable 2
       |
       v
Target Discovery
       |
       v
Nmap TCP / UDP Scanning
       |
       v
Service & Version Detection
       |
       v
OS Fingerprinting
       |
       v
Nessus Vulnerability Scan
       |
       v
Finding Correlation
       |
       v
Risk Analysis
       |
       v
Remediation Recommendations
```

---

## 1. Nmap Reconnaissance

The Nmap report documents a reconnaissance workflow covering host discovery, TCP scanning, UDP scanning, service/version detection, OS fingerprinting, and combined output collection.

### Commands Documented in the Report

```bash
nmap -sn 192.168.23.0/24
```

Host discovery / ping sweep.

```bash
nmap -sS 192.168.23.130
```

TCP SYN scan to identify open TCP ports.

```bash
nmap -sU 192.168.23.130
```

UDP scan.

```bash
nmap -sV 192.168.23.130
```

Service and version detection.

```bash
nmap -O 192.168.23.130
```

OS fingerprinting.

```bash
nmap -sS -sV -O -oN nmap_scan.txt 192.168.23.130
```

Combined TCP SYN, service/version, and OS detection with results saved to `nmap_scan.txt`.

---

## 2. Nmap Open-Port Findings

The Nmap report identifies the following TCP services:

| Port | State | Service |
|---:|---|---|
| 21 | Open | FTP |
| 22 | Open | SSH |
| 23 | Open | Telnet |
| 25 | Open | SMTP |
| 53 | Open | DNS |
| 80 | Open | HTTP |
| 111 | Open | rpcbind |
| 139 | Open | NetBIOS-SSN |
| 445 | Open | SMB / Samba |
| 512 | Open | exec |
| 513 | Open | login |
| 514 | Open | shell |
| 1099 | Open | rmiregistry |
| 1524 | Open | ingreslock / backdoor shell |
| 2049 | Open | NFS |
| 2121 | Open | FTP / ProFTPD |
| 3306 | Open | MySQL |
| 3632 | Open | distccd |
| 5432 | Open | PostgreSQL |
| 5900 | Open | VNC |
| 6000 | Open | X11 |
| 6667 | Open | IRC |
| 8009 | Open | AJP13 |
| 8180 | Open | HTTP / Tomcat |

The report describes the resulting attack surface as extensive, with numerous outdated, misconfigured, and intentionally backdoored services.

---

## 3. Service and Version Enumeration

The Nmap report records or gives expected service-version findings including:

| Port | Service | Version / Identification |
|---:|---|---|
| 21 | FTP | vsftpd 2.3.4 |
| 22 | SSH | OpenSSH 4.7p1 Debian |
| 23 | Telnet | Linux telnetd |
| 25 | SMTP | Postfix smtpd |
| 80 | HTTP | Apache 2.2.8 (Ubuntu) |
| 3306 | MySQL | MySQL 5.0.51a-3ubuntu5 |
| 5432 | PostgreSQL | PostgreSQL 8.3.0-8.3.7 |
| 8180 | HTTP | Apache Tomcat/Coyote JSP engine 1.1 |

The Nmap report also notes an older Linux 2.6.x kernel fingerprint as typical for Metasploitable 2.

---

## 4. UDP Findings

The Nmap report notes that UDP scans may return `open|filtered` results because a lack of response does not necessarily indicate that a UDP port is closed.

Common candidates documented in the report include:

- `53/udp` — domain
- `111/udp` — rpcbind
- `137/udp` — NetBIOS name service

---

## 5. Nessus Vulnerability Assessment

The Nessus report describes a full, non-credentialed vulnerability assessment covering TCP ports and standard service/version detection plugins.

The methodology included:

1. Target discovery
2. Nessus scanner configuration
3. Full non-credentialed scanning
4. Open-port and service enumeration
5. Software-version fingerprinting
6. Vulnerability correlation against the scanner plugin database
7. CVE correlation where applicable
8. Manual review and cross-reference against Nmap results

### Findings by Severity

| Severity | Findings |
|---|---:|
| Critical | 4 |
| High | 3 |
| Medium | 3 |
| Low | 1 |
| Informational | 1 |

---

## 6. Detailed Vulnerability Findings

### F-01 — VSFTPD v2.3.4 Backdoor Command Execution

- **Severity:** Critical
- **CVSS:** 10.0 (CVSS v2) / 9.8 (CVSS v3 equivalent)
- **Host:** `192.168.23.130`
- **Port:** `21/tcp`
- **Service:** FTP / vsftpd 2.3.4
- **Nessus Plugin:** 55523 — VSFTPD Smiley Face Backdoor
- **Reference:** CVE-2011-2523

The Nessus report describes the installed vsftpd 2.3.4 release as a maliciously trojaned version. The report documents that a username containing `:)` can trigger a backdoor listener on TCP port 6200.

**Impact:** Unauthenticated remote compromise with root-level privileges.

**Remediation documented in the report:**

- Remove or replace vsftpd 2.3.4 with a current supported release.
- Verify package checksums against official sources.
- Disable anonymous/unauthenticated FTP when not required.
- Keep the host isolated until remediated.

---

### F-02 — UnrealIRCd Backdoor Command Execution

- **Severity:** Critical
- **CVSS:** 10.0 (CVSS v2) / 9.8 (CVSS v3 equivalent)
- **Host:** `192.168.23.130`
- **Port:** `6667/tcp`
- **Service:** IRC / UnrealIRCd
- **Nessus Plugin:** 43093
- **Reference:** CVE-2010-2075

The report identifies a compromised UnrealIRCd build containing a backdoor that can execute system commands sent to the IRC listener.

**Impact:** Unauthenticated remote code execution as the IRC daemon service account.

**Remediation documented in the report:**

- Remove the compromised build.
- Reinstall from a verified current source.
- Restrict IRC exposure to trusted network segments.
- Monitor outbound connections from the IRC service account.

---

### F-03 — Java RMI Registry Insecure Default Configuration

- **Severity:** Critical
- **CVSS:** 9.8 (CVSS v3 equivalent)
- **Host:** `192.168.23.130`
- **Port:** `1099/tcp`
- **Service:** Java RMI
- **Nessus Plugin:** 51988
- **Reference:** CVE-2011-3556

The report describes an RMI registry configuration that accepts remote class-loading calls and can allow unauthenticated remote code execution.

**Remediation documented in the report:**

- Do not expose RMI to untrusted networks.
- Upgrade to a Java Runtime that enforces class-loading restrictions.
- Bind RMI services to localhost or a management-only interface.

---

### F-04 — distcc Remote Code Execution

- **Severity:** Critical
- **CVSS:** 9.8
- **Host:** `192.168.23.130`
- **Port:** `3632/tcp`
- **Service:** distccd
- **Nessus Plugin:** 34090
- **Reference:** CVE-2004-2687

The report states that distccd is running without access controls and can permit unauthenticated remote command execution.

**Remediation documented in the report:**

- Disable distccd where it is not required.
- Restrict access to trusted build hosts where necessary.
- Use `--allow` restrictions and least-privilege service accounts.

---

### F-05 — NFS Share Exported with Insecure Permissions

- **Severity:** High
- **CVSS:** 7.5
- **Host:** `192.168.23.130`
- **Ports:** `2049/tcp`, `111/tcp`
- **Service:** NFS / rpcbind
- **Nessus Plugin:** 11356

The report documents an NFS export of `/` with unrestricted access.

**Impact:** Unauthorized filesystem read/write access, with potential for data theft, tampering, or planting files.

**Remediation documented in the report:**

- Restrict NFS exports to trusted host ranges in `/etc/exports`.
- Apply `root_squash`.
- Use read-only exports where write access is unnecessary.
- Firewall rpcbind/NFS ports from untrusted networks.

---

### F-06 — Samba Vulnerable to Remote Code Execution

- **Severity:** High
- **CVSS:** 9.8
- **Host:** `192.168.23.130`
- **Ports:** `139/tcp`, `445/tcp`
- **Service:** Samba
- **Nessus Plugin:** 63459
- **Reference:** CVE-2007-2447

The report identifies a Samba username-map-script command execution vulnerability.

**Remediation documented in the report:**

- Upgrade Samba to a patched supported release.
- Remove or disable the username map script configuration.
- Restrict SMB access to trusted internal hosts.

---

### F-07 — Rlogin / Rsh / Rexec Cleartext Remote Login Services

- **Severity:** High
- **CVSS:** 7.5
- **Host:** `192.168.23.130`
- **Ports:** `512/tcp`, `513/tcp`, `514/tcp`
- **Services:** exec, login, shell
- **Nessus Plugin:** 10205
- **Reference:** CWE-319

The report identifies legacy BSD r-services that use host/user trust relationships and transmit credentials/session data in cleartext.

**Remediation documented in the report:**

- Disable rlogin/rsh/rexec.
- Replace them with SSH.
- Audit and remove `.rhosts` and `hosts.equiv` trust configurations.

---

### F-08 — Unencrypted Telnet Service

- **Severity:** Medium
- **CVSS:** 5.9
- **Host:** `192.168.23.130`
- **Port:** `23/tcp`
- **Service:** Telnet
- **Nessus Plugin:** 42263
- **Reference:** CWE-319

The report states that Telnet transmits authentication credentials and session traffic in cleartext.

**Remediation documented in the report:**

- Disable Telnet and replace it with SSH.
- If retained for lab purposes, restrict it to an isolated management VLAN.

---

### F-09 — MySQL and PostgreSQL Weak/Default Credentials

- **Severity:** Medium
- **CVSS:** 6.5
- **Host:** `192.168.23.130`
- **Ports:** `3306/tcp`, `5432/tcp`
- **Services:** MySQL, PostgreSQL
- **Nessus Plugin:** 10719

The report identifies network-accessible databases using weak or default credentials.

**Remediation documented in the report:**

- Set strong, unique passwords.
- Bind database services to localhost or an application-only network.
- Remove default/sample accounts and databases.

---

### F-10 — Apache Tomcat Default/Weak Manager Credentials

- **Severity:** Medium
- **CVSS:** 6.8
- **Host:** `192.168.23.130`
- **Port:** `8180/tcp`
- **Service:** Apache Tomcat/Coyote
- **Nessus Plugin:** 12085
- **Reference:** CWE-798

The report states that the Tomcat Manager application accepts default credentials and can allow WAR-file deployment.

**Remediation documented in the report:**

- Change or remove default Tomcat Manager credentials.
- Restrict Manager access to localhost or an administrative network.
- Upgrade Tomcat to a current supported version.

---

### F-11 — X11 Server Access Control Disabled

- **Severity:** Low
- **CVSS:** 3.7
- **Host:** `192.168.23.130`
- **Port:** `6000/tcp`
- **Service:** X11
- **Nessus Plugin:** 10407
- **Reference:** CWE-284

The report identifies an X11 server listening without access control.

**Remediation documented in the report:**

- Disable X11 forwarding/listening when a GUI is not required.
- Enable X11 access controls when it must remain enabled.

---

### F-12 — SSL/TLS and Service Banner Information Disclosure

- **Severity:** Informational
- **CVSS:** N/A
- **Host:** `192.168.23.130`
- **Port:** Multiple
- **Nessus Plugin:** 10267
- **Reference:** CWE-200

The report identifies verbose service banners exposing software names and versions, including examples such as vsftpd 2.3.4, Apache 2.2.8, and OpenSSH 4.7p1.

**Remediation documented in the report:**

- Suppress or minimize service banners where feasible.
- Treat banner reduction as a defense-in-depth measure.

---

## 7. Risk Analysis

The Nessus report groups remediation into four priority levels:

### Priority 1 — Unauthenticated RCE

The report places these findings in the first remediation group:

- F-01 — VSFTPD backdoor
- F-02 — UnrealIRCd backdoor
- F-03 — Java RMI
- F-04 — distcc

These findings are described as allowing command execution without credentials.

### Priority 2 — Network-Accessible RCE / Filesystem Exposure

- F-05 — NFS
- F-06 — Samba

### Priority 3 — Cleartext Protocols and Weak Credentials

- F-07 — r-services
- F-08 — Telnet
- F-09 — MySQL/PostgreSQL credentials
- F-10 — Tomcat Manager credentials

### Priority 4 — Lower-Impact / Informational

- F-11 — X11
- F-12 — Service banner disclosure

---

## 8. Nmap and Nessus Correlation

The Nessus report explicitly describes manual cross-checking of vulnerability findings against the earlier Nmap service scan.

Examples of correlated evidence include:

| Vulnerability | Nessus Evidence | Nmap Evidence |
|---|---|---|
| VSFTPD backdoor | Plugin 55523 | `21/tcp` FTP, vsftpd 2.3.4 |
| UnrealIRCd backdoor | Plugin 43093 | `6667/tcp` IRC |
| Java RMI RCE | Plugin 51988 | `1099/tcp` Java RMI |
| distcc RCE | Plugin 34090 | `3632/tcp` distccd |
| NFS exposure | Plugin 11356 | `2049/tcp` NFS / `111/tcp` rpcbind |
| Samba RCE | Plugin 63459 | `139/tcp`, `445/tcp` Samba |
| r-services | Plugin 10205 | `512/tcp`, `513/tcp`, `514/tcp` |
| Telnet | Plugin 42263 | `23/tcp` Telnet |
| Database exposure | Plugin 10719 | `3306/tcp`, `5432/tcp` |
| Tomcat credentials | Plugin 12085 | `8180/tcp` Tomcat |
| X11 | Plugin 10407 | `6000/tcp` X11 |

This correlation demonstrates how **Nmap reconnaissance identifies exposed services**, while **Nessus adds vulnerability detection, severity classification, and remediation context**.

---

## 9. Remediation Themes

Across both reports, the recommended defensive actions include:

- Remove or disable backdoored and unnecessary services.
- Patch or replace vulnerable applications.
- Replace Telnet and legacy r-services with SSH.
- Restrict database, RPC, NFS, SMB, and administrative services using firewall controls.
- Eliminate default, blank, and weak credentials.
- Apply network segmentation.
- Limit inbound access to required ports/services.
- Minimize service banners.
- Monitor authentication attempts and anomalous service activity.
- Perform regular vulnerability scanning and re-testing after remediation.

---

## 10. Key Learning Outcomes

This assessment demonstrates the relationship between reconnaissance and vulnerability assessment:

```text
Nmap
  |
  +--> What ports are exposed?
  |
  +--> What services are running?
  |
  +--> What versions are detected?
  |
  v
Nessus
  |
  +--> Which known vulnerabilities are associated?
  |
  +--> What is the scanner severity?
  |
  +--> What evidence supports the finding?
  |
  +--> What remediation is recommended?
```

The reports illustrate the importance of:

- Attack-surface discovery
- Service enumeration
- Version identification
- Automated vulnerability assessment
- Manual validation and cross-referencing
- Risk-based remediation
- Network segmentation
- Secure authentication
- Service minimization
- Patch management

---

## 11. Repository Contents

A suggested repository structure based on these two assessment reports is:

```text
metasploitable2-security-assessment/
│
├── README.md
│
├── reports/
│   ├── Nmap Scan Report.pdf
│   └── Nessus Vulnerability Report.pdf
│
└── evidence/
    └── screenshots/
```

Only include screenshots or additional evidence if they are actually part of the repository.

---

## 12. Reports

### Nmap Scan Report

Documents:

- Assessment scope
- Nmap methodology
- Host discovery
- TCP and UDP scanning
- Service/version detection
- OS fingerprinting
- Open-port findings
- Risk analysis
- Recommendations

### Nessus Vulnerability Report

Documents:

- Vulnerability assessment methodology
- Severity summary
- Detailed findings F-01 through F-12
- Nessus plugin evidence
- CVE/CWE references included in the report
- Impact statements
- Remediation guidance
- Risk prioritization

---

## 13. Responsible Use

This repository documents a cybersecurity training assessment performed against **Metasploitable 2**, an intentionally vulnerable target.

Use the documented scanning and assessment techniques only:

- In authorized environments
- Against systems provided for security testing
- Within isolated laboratory networks where appropriate

Do not apply these techniques to systems without explicit authorization.

---

## Author

**Debika Goswami**

**Program:** Cybersecurity & Ethical Hacking Internship Program

**Assessment Date:** 11-09-2026

---


