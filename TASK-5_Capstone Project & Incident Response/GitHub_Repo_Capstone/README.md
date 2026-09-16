# Vulnerability Assessment of Test Network.

## Purpose
Controlled vulnerability-assessment and exploitation-validation capstone performed only against the intentionally vulnerable Metasploitable2 VM in an isolated VMware Host-Only lab.

## Methodology
1. Discover — Nmap host/service discovery
2. Enumerate — service/version and OS detection
3. Assess — Nessus vulnerability scan
4. Corroborate — compare Nmap/Nessus evidence
5. Validate — controlled Metasploit Framework exploitation of one identified vulnerability
6. Document — evidence, impact, remediation
7. Remediate — patch/disable/restrict affected service
8. Retest — Nmap + Nessus and, if required, controlled MSF validation

## Evidence policy
Do not invent scan results. Replace every `[INSERT ACTUAL ...]` field with the learner's captured lab output.

## Repository structure
- `scripts/` — safe helper commands/templates
- `notes/` — methodology and finding notes
- `evidence/` — screenshots exported from the actual lab
- `reports/` — final report and supporting exports
- `README.md` — project overview

## Suggested evidence naming
01-topology.png
02-nmap-service-version.png
03-nmap-full-port.png
04-nmap-vuln.png
05-nessus-config.png
06-nessus-dashboard.png
07-nessus-finding.png
08-msf-module.png
09-msf-options.png
10-msf-session-sysinfo.png
11-msf-hashdump.png
12-retest.png

