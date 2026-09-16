# Metasploitable 2 Penetration Testing

## Exploitation, Reverse Shell and Post-Exploitation Assessment

This repository documents a controlled penetration-testing exercise performed against **Metasploitable 2**, an intentionally vulnerable Linux system used for cybersecurity training.

The assessment demonstrates how a known vulnerability can be identified and exploited in an authorized laboratory environment, followed by establishment of a reverse shell and limited post-exploitation activities.

---

## ⚠️ Disclaimer

This project was conducted exclusively against an intentionally vulnerable Metasploitable 2 virtual machine in an isolated and authorized laboratory environment.

The techniques documented here must only be used against systems for which explicit authorization has been obtained.

Do not use these techniques against public, production, or third-party systems without permission.

---

# 1. Project Objectives

The objectives of this project were to:

- Identify a vulnerable service on Metasploitable 2.
- Investigate a known vulnerability.
- Perform controlled exploitation.
- Establish a reverse shell.
- Confirm access to the target system.
- Collect basic system information.
- Demonstrate access to password-hash information.
- Assess the security impact.
- Document appropriate mitigations.
- Verify the security implications of the compromise.

---

# 2. Laboratory Environment

| Component | Details |
|---|---|
| Attacker | Kali Linux |
| Target | Metasploitable 2 |
| Target IP | `192.168.23.128` |
| Network | Isolated virtual network |
| Framework | Metasploit Framework |
| Enumeration | Nmap |
| Target Type | Intentionally vulnerable Linux VM |

### Network Architecture

```text
                    Isolated Lab Network

             ┌────────────────────────┐
             │       Kali Linux       │
             │    Attacker Machine    │
             │                        │
             │  Nmap / Metasploit     │
             └───────────┬────────────┘
                         │
                         │
                    Virtual Network
                         │
                         │
             ┌───────────▼────────────┐
             │     Metasploitable 2   │
             │      Target Server     │
             │                        │
             │    192.168.23.128      │
             └────────────────────────┘
```

---

# 3. Assessment Methodology

The assessment followed this workflow:

```text
Reconnaissance
      ↓
Service Enumeration
      ↓
Vulnerability Identification
      ↓
Exploit Selection
      ↓
Controlled Exploitation
      ↓
Reverse Shell
      ↓
Access Verification
      ↓
Post-Exploitation
      ↓
Impact Assessment
      ↓
Mitigation
```

---

# 4. Attack Summary

The assessment demonstrated the following attack chain:

```text
Exposed Vulnerable Service
          ↓
Known Vulnerability
          ↓
Controlled Exploitation
          ↓
Remote Code Execution
          ↓
Reverse Shell
          ↓
System Access
          ↓
sysinfo
          ↓
hashdump
```

The successful exploitation demonstrated that a vulnerable network-facing service can provide an attacker with a path from remote network access to operating-system-level access.

---

# 5. Exploitation Documentation

Detailed exploitation documentation is available in:

- `exploitation/01-reconnaissance.md`
- `exploitation/02-vulnerability-identification.md`
- `exploitation/03-exploitation.md`
- `exploitation/04-reverse-shell.md`
- `exploitation/05-post-exploitation.md`

The documentation describes the assessment process without targeting systems outside the authorized laboratory.

---

# 6. Post-Exploitation

After obtaining the remote session, limited post-exploitation activities were performed.

### System Information

The `sysinfo` functionality was used to confirm information about the compromised operating system.

### Password Hash Demonstration

The `hashdump` functionality was used to demonstrate whether the compromised session had sufficient privileges to access password-hash information.

These activities were performed only on the intentionally vulnerable laboratory target.

---

# 7. Findings

| ID | Finding | Severity | Result |
|---|---|---|---|
| MSF-001 | Known vulnerable service | Critical | Exploited |
| MSF-002 | Remote shell access | Critical | Confirmed |
| MSF-003 | System information disclosure | High | Confirmed |
| MSF-004 | Password-hash access | Critical | Demonstrated |

---

# 8. Security Impact

Successful exploitation may affect all three core security properties.

### Confidentiality

An attacker may gain access to sensitive system information, user information, files, and authentication-related data.

### Integrity

With sufficient privileges, an attacker may modify files, configurations, services, or other system resources.

### Availability

An attacker with extensive system access may disrupt services or modify system configurations.

---

# 9. Mitigation Summary

Recommended mitigations include:

### 1. Patch Vulnerable Services

Update vulnerable services to supported versions containing the appropriate security fixes.

### 2. Remove Unnecessary Services

Services that are not required should be disabled and removed.

### 3. Restrict Network Access

Use firewall rules and access-control policies to prevent unnecessary exposure.

### 4. Apply Least Privilege

Network-facing services should run with only the privileges they require.

### 5. Segment the Network

Sensitive servers should be isolated from untrusted networks.

### 6. Strengthen Authentication

Use strong authentication controls and protect authentication databases.

### 7. Monitor for Exploitation

Security monitoring should detect suspicious connections, unusual processes, privilege escalation, and unauthorized access.

---

# 10. Evidence

Screenshots supporting the assessment are stored in the `evidence/` directory.

| Evidence | Description |
|---|---|
| `01-lab-environment.png` | Virtual laboratory |
| `02-nmap-enumeration.png` | Service enumeration |
| `03-exploit-configuration.png` | Exploit configuration |
| `04-reverse-shell.png` | Successful remote session |
| `05-system-access.png` | Access verification |
| `06-sysinfo.png` | System information |
| `07-hashdump.png` | Password-hash demonstration |

---

# 11. Deliverables

This repository accompanies the penetration-testing assessment report and demonstration video.

### Report

`report/penetration-testing-report.pdf`

### Exploitation Documentation

`exploitation/`

### Mitigation Documentation

`mitigations/`

### Evidence

`evidence/`

---

# 12. Key Learning Outcomes

This exercise demonstrates:

- Vulnerability identification
- Service enumeration
- Controlled exploitation
- Reverse-shell concepts
- Remote system access
- Post-exploitation reconnaissance
- Security impact assessment
- Vulnerability remediation
- Security verification
- Professional security documentation

---

# 13. Conclusion

The assessment demonstrated how exploitation of a known vulnerability can result in unauthorized operating-system access.

The exercise also showed that the initial compromise can enable further post-exploitation activities, including system-information discovery and access to password-hash information when sufficient privileges are available.

The primary defensive lesson is that vulnerable network services should not remain unnecessarily exposed. Organizations should maintain supported software, apply security patches, reduce exposed services, enforce least privilege, segment networks, and continuously monitor systems for suspicious activity.

---

## Repository Structure

```text
metasploitable2-penetration-testing/
│
├── README.md
├── docs/
├── exploitation/
├── mitigations/
├── evidence/
└── report/
```

---

**Assessment Type:** Authorized cybersecurity laboratory exercise  
**Target:** Metasploitable 2  
**Target IP:** `192.168.23.128`