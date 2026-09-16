# Methodology Notes

## Rules of Engagement
Target only the Metasploitable2 VM on the isolated VMware Host-Only network.

## Nmap
Use the supplied assessment sequence:
- `nmap -sS <TARGET>`
- `nmap -sV <TARGET>`
- `nmap -sU <TARGET>`
- `nmap -O <TARGET>`
- `nmap -Pn -p- <TARGET>`
- `nmap -T4 <TARGET>`
- `nmap -Pn --script vuln <TARGET>`

The supplied assessment reports 12 open TCP ports and explicitly identifies 22/SSH, 80/HTTP and 445/SMB.

## Nessus
Run the approved scan against the lab target. Record:
- target
- scan policy
- completion time
- severity counts
- plugin ID/title
- affected port/service
- plugin evidence
- remediation
- export filename

## Metasploit
After identifying a suitable vulnerability:
1. Start `msfconsole`
2. Search for the relevant module
3. Review module information
4. Configure only required target options
5. Execute against the isolated lab target
6. Validate the session
7. Capture permitted evidence such as `sysinfo`; capture `hashdump` only where explicitly required and authorized
8. Exit and clean up

Do not run these procedures against external or production systems.
