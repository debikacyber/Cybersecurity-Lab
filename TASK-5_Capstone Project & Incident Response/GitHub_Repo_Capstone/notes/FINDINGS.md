# Finding Notes

## N-01 — Exposed Services
**Source:** Nmap  
**Evidence:** Full TCP sweep reported 12 open ports, including 22, 80 and 445.  
**Risk:** Larger exposed attack surface.  
**Remediation:** Disable unnecessary services and restrict access.

## N-02 — Outdated Software
**Source:** Nmap version detection  
**Evidence:** Supplied report identifies significantly outdated service versions.  
**Remediation:** Patch/upgrade and retest.

## N-03 — Samba 3.x Exposure
**Source:** Nmap `--script vuln`  
**Evidence:** Supplied report states an unpatched Samba 3.x service with potential known RCE exposure.  
**Remediation:** Patch/upgrade Samba; disable or restrict SMB where unnecessary.

## N-04 — Nessus Finding
Insert the exact Nessus plugin ID, title, severity, CVE/CVSS (as reported), affected service, evidence and remediation from the actual scan export.

## M-01 — Metasploit Validation
Insert the exact MSF module, target service/version, options, payload (if used), session result and screenshots from the actual controlled lab run.
