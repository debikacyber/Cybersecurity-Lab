Passive Reconnaissance
Passive reconnaissance involves gathering information without directly interacting with the target's systems. This information is publicly available.

Whois: A command-line tool used to query a public database for information about a domain, such as the owner, contact details, and registration dates.

How to use:
                                                                                                                                 
┌──(kali㉿kali)-[~]
└─$ whois google.com     
   Domain Name: GOOGLE.COM
   Registry Domain ID: 2138514_DOMAIN_COM-VRSN
   Registrar WHOIS Server: whois.markmonitor.com
   Registrar URL: http://www.markmonitor.com
   Updated Date: 2019-09-09T15:39:04Z
   Creation Date: 1997-09-15T04:00:00Z
   Registry Expiry Date: 2028-09-14T04:00:00Z
   Registrar: MarkMonitor Inc.
   Registrar IANA ID: 292
   Registrar Abuse Contact Email: abusecomplaints@markmonitor.com
   Registrar Abuse Contact Phone: +1.2086851750
   Domain Status: clientDeleteProhibited https://icann.org/epp#clientDeleteProhibited
   Domain Status: clientTransferProhibited https://icann.org/epp#clientTransferProhibited
   Domain Status: clientUpdateProhibited https://icann.org/epp#clientUpdateProhibited
   Domain Status: serverDeleteProhibited https://icann.org/epp#serverDeleteProhibited
   Domain Status: serverTransferProhibited https://icann.org/epp#serverTransferProhibited
   Domain Status: serverUpdateProhibited https://icann.org/epp#serverUpdateProhibited
   Name Server: NS1.GOOGLE.COM
   Name Server: NS2.GOOGLE.COM
   Name Server: NS3.GOOGLE.COM
   Name Server: NS4.GOOGLE.COM


Nslookup: A tool for querying the DNS to find information like a domain's IP address, mail servers, and name servers.

How to use:

(kali㉿kali)-[~]
└─$ nslookup google.com  
Server:         49.205.72.130
Address:        49.205.72.130#53

Non-authoritative answer:
Name:   google.com
Address: 142.250.183.174
Name:   google.com
Address: 2404:6800:4007:815::200e


Google Dorking: Using advanced search operators in a search engine to find hidden or specific information on a website.

Shodan: A search engine for internet-connected devices that can find public servers, services, and IoT devices.

Active Reconnaissance
Active reconnaissance involves direct interaction with the target network to gather information.

Ping Sweep: A method for sending ICMP (ping) packets to a range of IP addresses to identify which hosts are online and active on a network.

How to use: nmap -sn 192.168.56.0/24

Banner Grabbing: Connecting to a network service to retrieve its introductory message or "banner," which often contains the software name and version number.

How to use: nc -nv [target_ip_address] 80

