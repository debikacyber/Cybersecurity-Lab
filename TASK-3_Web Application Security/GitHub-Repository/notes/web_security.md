1. Objective and Scope
This section documents the process of analyzing and hardening the web server configuration to improve security posture. The objective was to diagnose missing HTTP security headers on the target application and implement key headers in the Apache configuration to mitigate common browser-based attacks.

2. Baseline Analysis and Diagnosis
Baseline Scan
A baseline analysis of the target application (http://192.168.56.4/mutillidae/) was performed using the external tool securityheaders.com.

Initial Grade: The analysis returned a failing grade (typically an F or D).

Missing Headers: The scan revealed that several critical security headers were either missing entirely or incorrectly configured, leaving the application vulnerable to attacks like Clickjacking and MIME-sniffing.

Vulnerability Identified
The lack of proper security headers is a configuration vulnerability that relies on the browser to enforce security rules. Without headers, an attacker can more easily embed the application in malicious iframes or trick the browser into misinterpreting content.

3. Mitigation: Implementation of Security Headers
The following actions were taken on the Metasploitable2 VM to harden the Apache web server configuration.

Configuration Steps
Module Enablement: The Apache headers module was enabled to allow custom HTTP headers to be set:

Bash

sudo a2enmod headers
Configuration File Modification: The main Apache site configuration file (/etc/apache2/sites-available/default or similar) was edited.

Header Insertion: The following four essential security headers were added inside the <VirtualHost> tags to ensure they are sent with every web response:

Apache

Header always set X-Frame-Options "DENY"
Header always set X-XSS-Protection "1; mode=block"
Header always set X-Content-Type-Options "nosniff"
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
Service Restart: The Apache web service was restarted to apply the new configuration:

Bash

sudo /etc/init.d/apache2 restart
Purpose of Implemented Headers
Header	Value	Security Benefit
X-Frame-Options	DENY	Prevents the page from being loaded into any <iframe> or <frame> on another domain, effectively mitigating Clickjacking attacks.
X-XSS-Protection	1; mode=block	Instructs modern browsers to enable their built-in Cross-Site Scripting (XSS) filter. If an XSS attack is detected, the browser will block the page from rendering.
X-Content-Type-Options	nosniff	Prevents the browser from "MIME-sniffing" the response content type. This protects against attackers trying to disguise harmful files (like scripts) as harmless file types.
Strict-Transport-Security	max-age=...	HSTS (HTTP Strict Transport Security) forces the browser to communicate with the server only over HTTPS for the specified time, protecting against downgrade attacks.
4. Final Analysis and Conclusion
Post-Mitigation Scan
After the configuration changes and the Apache restart, the application URL was re-scanned on securityheaders.com.

Final Grade: The grade was significantly improved (typically moving to B or A), demonstrating the effectiveness of the configuration changes.

Conclusion: Implementing security headers is a cost-effective and essential layer of defense for any web application. It shifts security enforcement from the application code (where vulnerabilities often arise) to the web server and the user's browser, providing immediate protection against a wide range of common web attacks.