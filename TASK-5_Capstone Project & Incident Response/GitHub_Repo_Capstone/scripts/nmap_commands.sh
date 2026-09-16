#!/bin/bash
# Replace TARGET with the isolated Metasploitable2 IP.
TARGET="<TARGET_IP>"
nmap -sS "$TARGET"
nmap -sV "$TARGET"
nmap -sU "$TARGET"
nmap -O "$TARGET"
nmap -Pn -p- "$TARGET"
nmap -T4 "$TARGET"
nmap -Pn --script vuln "$TARGET"
