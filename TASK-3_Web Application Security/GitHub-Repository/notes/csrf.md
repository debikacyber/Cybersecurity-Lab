1. Objective and Scope
This section documents the execution and analysis of a Cross-Site Request Forgery (CSRF) attack against a vulnerable function in the web application (Mutillidae on Metasploitable2 VM). The objective was to successfully force a state-changing action (password change) on a logged-in user and to document the crucial token-based defense mechanism required for mitigation.

2. Vulnerability Description and Execution
Vulnerability Discovered
The application's Change Password function was found to be vulnerable to CSRF. This vulnerability exists because the application accepts the password change request based only on the user's valid session cookie, without requiring any unique, unpredictable secret (a token) that validates the request's origin.

Execution Process (The Attack)
The attack was performed by following these steps:

Request Interception (Burp Suite): The legitimate Change Password request was captured using Burp Suite while a user (admin) was logged in. The intercepted request revealed all the necessary parameters needed for a successful password change (e.g., current_password, new_password, confirm_password).

PoC Generation: Burp Suite's Generate CSRF PoC tool was used to create a simple HTML file containing a malicious, hidden form pre-filled with the attacker's desired new password (Hacked123).

Attack Execution: The generated HTML file (csrf_attack.html) was loaded in the victim's browser while they were still authenticated with the application.

Result: The hidden form automatically submitted the malicious request to the vulnerable server. The server validated the user based only on the existing session cookie and executed the password change without requiring the user's interaction or consent.

Successful Compromise (Evidence)
The attack was successful, leading to unauthorized modification of user data. The logged-in user's password was changed to the attacker's value (Hacked123), leading to a loss of account control. This proves that an attacker could force any logged-in user to perform arbitrary actions, such as changing their email, transferring funds, or deleting an account.

3. Mitigation and Prevention (Anti-CSRF Tokens)
The core principle for preventing CSRF is to introduce an element into the request that the attacker cannot know or guess.

Required Mitigation: Anti-CSRF Tokens
Anti-CSRF Tokens are the industry-standard defense against this vulnerability.

Token Generation: The server must generate a unique, random, and cryptographically secure token for every session.

Token Placement: This token is embedded as a hidden field in all state-changing forms (like the Change Password form).

Server Verification: When the server receives the request, it checks that the submitted token matches the token associated with the user's session.

Attack Failure: Because the malicious HTML file must originate from an external domain, the attacker cannot steal or guess the unique Anti-CSRF Token. When the external request reaches the server, the token will be missing or invalid, and the server will correctly reject the request.

This protection ensures that only requests originating from the trusted application itself can successfully execute critical actions.s