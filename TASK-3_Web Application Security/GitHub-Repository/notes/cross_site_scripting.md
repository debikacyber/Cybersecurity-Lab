1. Objective and Scope
This section documents the execution and analysis of both Reflected XSS and Stored XSS attacks against the vulnerable web application (Mutillidae on the Metasploitable2 VM). The objective was to successfully exploit the application due to a lack of proper input validation and output encoding, and to document the necessary secure coding principles for mitigation.

2. Reflected XSS (Non-Persistent)
Vulnerability and Execution
Vulnerability: The application accepts user input (e.g., in a search bar) and immediately displays, or "reflects," that input back to the user's browser without properly encoding the HTML characters. This allows the browser to execute any injected script.
Target: A search or user lookup field within the Mutillidae application.
Payload Used: The standard test payload was used to confirm the vulnerability.
<script>alert('Reflected XSS Success!')</script>

Result: Upon submission, an alert box pop-up appeared on the screen with the message "Reflected XSS Success!". This proved that the attacker's script was executed by the victim's browser, demonstrating a successful compromise. This type of attack is often delivered via a malicious link.

3. Stored XSS (Persistent)
Vulnerability and Execution
Vulnerability: The application failed to sanitize the input before saving it to the database (lack of Input Validation) and failed to encode it when retrieved (lack of Output Encoding). This allows malicious code to be permanently saved.
Target: A persistent input field, such as the Blog Post or Guestbook feature in Mutillidae.
Payload Used: A more disruptive payload was used to demonstrate the persistence of the vulnerability.
<h1>HACKED!</h1><script>document.body.innerHTML = 'HACKED by Stored XSS!'</script>

Result: Upon submission, the script was stored in the database. When the page was viewed by any user (including the victim and the attacker), the script automatically executed, overwriting the entire content of the page with the "HACKED" message. This demonstrates a persistent, high-impact compromise.

4. Conclusion
The successful execution of both Reflected and Stored XSS attacks highlights critical security flaws in the target application's design. These vulnerabilities pose a severe risk of session hijacking, credential theft (by capturing cookies), and defacing the website.

The fundamental solution lies in treating all user input as untrusted data and implementing proper Output Encoding as a mandatory security gate before rendering the data to any user's browser.