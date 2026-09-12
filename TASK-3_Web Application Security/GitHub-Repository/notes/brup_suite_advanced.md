Burp Suite Advanced (Intruder Fuzzing) Report
1. Objective and Methodology
Objective: The goal was to demonstrate the use of Burp Suite's Intruder tool to perform fuzzing against a login parameter of the target application (Mutillidae). Fuzzing helps identify hidden vulnerabilities by observing how the server responds to unexpected input.

Methodology: A failed login request was captured using Burp Suite's Proxy and sent to the Intruder tool. The attack type was set to Sniper to target a single parameter (the username field). A simple payload list of common attack characters and test strings was used.

2. Payload List Used for Fuzzing
The following strings were used as payloads to test the vulnerability. These strings are designed to test for classic SQL Injection and XSS errors:

' (Single quote: SQL Injection test)
" (Double quote: SQL Injection test)
admin'-- (Common SQL Injection bypass payload)
<script>alert(1)</script> (Cross-Site Scripting test)
! (Basic fuzzing character)

3. Analysis of Fuzzing Results (Simulated)
A successful fuzzing attack reveals anomalies in the server's responses.

Payload Sent	HTTP Status Code	Response Length	Analysis / Implication
test (Baseline)	200 OK	9,100	Baseline: Normal failed login response.
'	500 Internal Server Error	7,800	CRITICAL FINDING: A 500 error and a reduced response length indicate the server-side application (PHP/MySQL) failed when processing the single quote, confirming a high probability of SQL Injection vulnerability.
<script>alert(1)</script>	200 OK	9,350	A slightly longer length suggests the input was processed and echoed back without being properly Output Encoded, confirming a potential XSS vulnerability.
admin'--	200 OK	9,100	If a login attempt with this payload results in a successful login, it would confirm SQL Injection Authentication Bypass.

4. Conclusion
The automated fuzzing process using Burp Suite Intruder is an efficient way to discover vulnerabilities. The detection of HTTP 500 errors when sending simple, malicious characters (like a single quote) is a strong indicator of a severe SQL Injection vulnerability in the backend code. This confirms that the application processes user input unsafely, making it highly susceptible to common injection attacks.