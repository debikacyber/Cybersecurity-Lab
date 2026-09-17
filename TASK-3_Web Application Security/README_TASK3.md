# TASK-3_Web Application Security


## Overview

This repository documents a controlled web application security
assessment performed against **Damn Vulnerable Web Application (DVWA)**
in an isolated VMware cybersecurity laboratory.

The assessment focused on demonstrating common web application security
weaknesses, analyzing their impact, and documenting recommended
mitigations. The primary areas covered were:

-   SQL Injection (SQLi)
-   Reflected Cross-Site Scripting (XSS)
-   Stored XSS
-   DOM-Based XSS
-   Cross-Site Request Forgery (CSRF)
-   Authentication weakness / brute-force simulation using Burp Suite

The assessment was performed on **September 11, 2026** using **Kali
Linux** against DVWA in an authorized laboratory environment.

> **Ethical and Responsible-Use Notice:** All activities documented in
> this repository were performed against intentionally vulnerable
> software in an isolated, authorized cybersecurity lab. The techniques
> must not be used against systems without explicit authorization.

------------------------------------------------------------------------

## Assessment Details

  Field                 Details
  --------------------- ---------------------------------------------
  Assessment Date       September 11, 2026
  Assessment Type       Web Application Security Assessment
  Testing Environment   Isolated VMware Cybersecurity Lab
  Testing Machine       Kali Linux
  Target Application    Damn Vulnerable Web Application (DVWA)
  SQL Database          MySQL
  Scope                 Authorized laboratory environment only
  Primary Tools         Burp Suite, Burp Intruder, Kali Linux, DVWA

The Security Testing Report identifies the objective as testing DVWA for
common vulnerabilities, analyzing their impact, and documenting security
best practices.

------------------------------------------------------------------------

------------------------------------------------------------------------

# 1. SQL Injection (SQLi)

## Objective

The SQL Injection testing was designed to demonstrate how
attacker-controlled input could modify an application's SQL query and
retrieve information that should not be available through the normal
application interface.

The report documents:

-   Retrieval of user records
-   Database table enumeration
-   Column enumeration
-   Extraction of usernames and password hashes

## Test Scenario

A normal input such as:

``` text
1
```

returned the record associated with ID 1.

A controlled Boolean SQL Injection test used:

``` text
1' OR '1'='1
```

The corresponding query logic was documented as:

``` sql
SELECT * FROM users WHERE id = '1' OR '1'='1'
```

The assessment reported that this allowed multiple user records to be
returned.

## Database Enumeration

The assessment then demonstrated controlled enumeration of the DVWA
database schema.

Documented tables included:

``` text
guestbook
users
```

The `users` table was further examined to identify fields including:

``` text
user_id
first_name
Sur_name
```

The report also documents extraction of usernames and MD5 password
hashes as part of the controlled laboratory exercise.

## Observed Impact

The SQL Injection testing demonstrated potential for:

-   Authentication bypass
-   Unauthorized record retrieval
-   Full table enumeration
-   Database schema disclosure
-   Exposure of authentication data
-   Subsequent compromise of accounts if exposed password hashes are
    cracked

The Security Testing Report describes SQL Injection as enabling access
to sensitive user and schema information.

------------------------------------------------------------------------

# 2. SQL Injection Mitigation

The primary remediation identified in the mitigation notes is:

**Use Prepared Statements / Parameterized Queries.**

### Vulnerable Pattern

``` text
User Input
    ↓
String Concatenation
    ↓
SQL Query
    ↓
Database
```

### Secure Pattern

``` text
User Input
    ↓
Input Validation
    ↓
Parameterized Query
    ↓
Database
```

A conceptual secure query is:

``` sql
SELECT * FROM users WHERE id = ?
```

The supplied ID should be bound as a parameter rather than concatenated
into the SQL statement.

### Additional Controls

-   Validate input according to the expected type.
-   Use allow-list validation where appropriate.
-   Use a least-privilege database account.
-   Do not expose database errors to users.
-   Log suspicious database activity safely.
-   Use secure password hashing such as Argon2id, bcrypt, or scrypt.
-   Retest the original SQL Injection case after remediation.

### Verification

The original SQL Injection test should be repeated after the fix.

Expected behavior:

``` text
Normal input
    ↓
Application works normally

Controlled SQLi test
    ↓
Input rejected or treated as data
    ↓
No unauthorized records returned
```

------------------------------------------------------------------------

# 3. Reflected XSS

## Objective

The Reflected XSS test examined whether user-controlled input was
reflected into the application's response without appropriate output
encoding.

## Controlled Test

The assessment used the harmless test payload:

``` html
<script>alert('XSS')</script>
```

The Security Testing Report documents that the payload executed
immediately in the browser.

## Impact

Potential consequences documented in the reports include:

-   Unauthorized JavaScript execution
-   Page-content manipulation
-   Session-related attacks depending on application design
-   Phishing or malicious UI injection
-   Unauthorized actions in the victim's browser context

## Mitigation

Recommended controls include:

-   Apply context-aware output encoding.
-   Validate input when a specific format is expected.
-   Avoid inserting untrusted data into executable contexts.
-   Use safe templating mechanisms.
-   Consider Content Security Policy (CSP) as defense in depth.

### Verification

Repeat the same controlled test and confirm that the payload is rendered
as text or safely rejected rather than executed.

------------------------------------------------------------------------

# 4. Stored XSS

## Objective

The Stored XSS test examined whether malicious input could be stored by
the application and later executed when another user viewed the stored
content.

## Controlled Test

The documented test used:

``` text
Name: test scrip
Message: <script>alert(1)</script>
```

The report documents that an alert appeared when the stored message was
rendered.

## Impact

Because stored content persists, the potential impact includes:

-   Persistent JavaScript execution
-   Page/UI manipulation
-   Session-related attacks
-   Phishing
-   Unauthorized browser actions

## Mitigation

Recommended controls:

1.  Encode output when displaying stored content.
2.  Sanitize HTML when users genuinely need to submit HTML.
3.  Use established HTML sanitization libraries.
4.  Avoid unsafe HTML insertion APIs.
5.  Implement Content Security Policy.
6.  Test every location where stored data is rendered.

### Verification

Previously stored test content should render harmlessly as text and must
not execute JavaScript.

------------------------------------------------------------------------

# 5. DOM-Based XSS

## Objective

The DOM-Based XSS assessment examined client-side JavaScript handling of
untrusted, URL-controlled data.

## Test

The assessment used the DVWA XSS (DOM) module and modified
URL-controlled input, including:

``` text
?default=Hindi
```

The report documents JavaScript execution caused by insufficient
sanitization in the client-side JavaScript.

### Vulnerable Data Flow

``` text
URL Parameter
    ↓
JavaScript
    ↓
Unsafe DOM Sink
    ↓
Browser Execution
```

## Impact

Potential consequences include:

-   JavaScript execution
-   Page manipulation
-   Phishing
-   Unauthorized browser actions
-   Session-related attacks depending on application design

## Mitigation

Recommended controls:

-   Avoid unsafe DOM sinks.
-   Prefer `textContent` for text insertion.
-   Safely process URL parameters.
-   Validate data before using it.
-   Avoid dynamically constructing executable JavaScript.
-   Use Content Security Policy as an additional defense layer.

### Verification

Repeat the original DOM-XSS test and confirm that URL-controlled input
cannot reach an executable JavaScript context.

------------------------------------------------------------------------

# 6. Cross-Site Request Forgery (CSRF)

## Objective

The CSRF scenario examines whether an authenticated user can be induced
to submit an unintended state-changing request.

The mitigation notes identify sensitive operations such as password
changes as appropriate controlled test cases.

## Test Methodology

The documented procedure is:

1.  Log into DVWA using an authorized laboratory account.
2.  Open the CSRF module.
3.  Capture the normal state-changing request.
4.  Inspect the request for an anti-CSRF token.
5.  Test the request with the token omitted or invalidated.
6.  Observe whether the server accepts the request.
7.  Restore the laboratory account to its original state.

The exact request parameters should be taken from the DVWA version
actually being tested.

## Potential Impact

A vulnerable state-changing operation could allow:

-   Unauthorized password changes
-   Unauthorized account changes
-   Modification of application settings
-   Other state-changing actions using the victim's authenticated
    session

## Mitigation

The primary control is an unpredictable, server-generated anti-CSRF
token.

### Secure Flow

``` text
Authenticated User
    ↓
State-changing Request
    ↓
CSRF Token
    ↓
Server-side Token Validation
    ↓
Accept / Reject
```

Additional controls include:

-   Validate tokens server-side.
-   Configure appropriate `SameSite` cookie protections.
-   Validate `Origin` and/or `Referer` where appropriate.
-   Avoid state-changing actions through GET requests.
-   Require re-authentication for highly sensitive actions.

### Verification

``` text
Valid token    → Request accepted
Missing token  → Request rejected
Invalid token  → Request rejected
```

------------------------------------------------------------------------

# 7. Authentication / Brute-Force Simulation

## Objective

The authentication exercise demonstrated how repeated login attempts can
be tested in an authorized laboratory environment.

## Tools

-   Kali Linux
-   DVWA
-   Burp Suite
-   Burp Intruder
-   Controlled/custom password wordlist

## Methodology

The Security Testing Report documents the following workflow:

1.  Configure DVWA for the laboratory test.
2.  Log in using an authorized account.
3.  Navigate to the DVWA Brute Force module.
4.  Submit a failed login attempt.
5.  Capture the HTTP POST request using Burp Suite.
6.  Send the request to Burp Intruder.
7.  Identify the password parameter as the controlled payload position.
8.  Load a laboratory wordlist.
9.  Execute a limited test.
10. Compare response behavior.

The report states that response codes and content-length differences
were used to identify successful authentication behavior.

## Result

The supplied assessment report records a successful controlled test
credential during the lab exercise.

> Credential values are intentionally not reproduced in this README.
> Refer to the supplied assessment evidence if required for the
> laboratory exercise.

## Security Impact

The assessment identified insufficient protection against repeated
automated authentication attempts.

Potential risks include:

-   Account compromise
-   Credential stuffing
-   Password guessing
-   Privilege escalation following account compromise

## Mitigation

Recommended controls include:

### 1. Rate Limiting

Limit repeated authentication attempts by account, user, device, or
network source.

### 2. Progressive Delays

Increase delays between repeated failed authentication attempts.

### 3. Multi-Factor Authentication

Use MFA, especially for privileged accounts.

### 4. Strong Password Policy

Require passwords resistant to guessing and prevent commonly compromised
passwords.

### 5. Bot Detection

Use CAPTCHA or equivalent controls where appropriate.

### 6. Monitoring

Detect unusual authentication patterns and generate security alerts.

### Verification

A remediation test should demonstrate that repeated automated attempts
are throttled, blocked, challenged, or otherwise prevented from
continuing at an unrestricted rate.

------------------------------------------------------------------------

# 8. Consolidated Findings

  ------------------------------------------------------------------------------------
  Finding        Demonstration    Potential Impact      Primary         Severity
                                                        Mitigation      
  -------------- ---------------- --------------------- --------------- --------------
  SQL Injection  Controlled SQL   Unauthorized database Prepared        Critical
                 query            access                statements /    
                 manipulation                           parameterized   
                                                        queries         

  SQLi Schema    Database         Database structure    Parameterized   High
  Enumeration    metadata         disclosure            queries + least 
                 enumeration                            privilege       

  SQLi           Controlled       Authentication-data   Prepared        Critical
  Credential     users-table      compromise            statements +    
  Exposure       extraction                             secure password 
                                                        hashing         

  Reflected XSS  Controlled       Browser-side script   Context-aware   Medium
                 script           execution             output encoding 
                 reflection                                             

  Stored XSS     Stored test      Persistent script     Output encoding High
                 script           execution             / sanitization  

  DOM-Based XSS  URL-controlled   Client-side script    Safe DOM APIs   High
                 client-side      execution                             
                 input                                                  

  CSRF           Unauthorized     Account/application   Anti-CSRF       High
                 state-changing   state modification    tokens          
                 request scenario                                       

  Brute Force    Controlled Burp  Account compromise    Rate limiting + High
                 Intruder                               MFA             
                 simulation                                             
  ------------------------------------------------------------------------------------

------------------------------------------------------------------------

# 9. Secure Coding Checklist

## SQL Injection

-   [ ] Prepared statements implemented
-   [ ] Input validation implemented
-   [ ] Database least privilege implemented
-   [ ] Database errors hidden from users
-   [ ] Secure password hashing implemented
-   [ ] SQLi regression test completed

## XSS

-   [ ] Output encoding implemented
-   [ ] Safe DOM APIs used
-   [ ] Unsafe HTML sinks reviewed
-   [ ] Stored content sanitized where required
-   [ ] Content Security Policy considered
-   [ ] XSS regression tests completed

## CSRF

-   [ ] Anti-CSRF tokens implemented
-   [ ] Tokens validated server-side
-   [ ] SameSite cookie policy configured
-   [ ] Sensitive operations protected
-   [ ] GET avoided for state-changing actions
-   [ ] CSRF regression tests completed

## Authentication

-   [ ] Rate limiting implemented
-   [ ] Progressive delays implemented
-   [ ] MFA enabled
-   [ ] Strong password policy implemented
-   [ ] Common/breached passwords blocked
-   [ ] Authentication monitoring enabled

------------------------------------------------------------------------

# 10. Remediation Verification

Each vulnerability should be retested after remediation.

### SQL Injection

``` text
Original SQLi Test
       ↓
Apply Prepared Statement
       ↓
Repeat Test
       ↓
No Query Manipulation
       ↓
PASS
```

### XSS

``` text
Original XSS Test
       ↓
Apply Output Encoding
       ↓
Repeat Test
       ↓
Payload Rendered as Text
       ↓
PASS
```

### CSRF

``` text
Original CSRF Test
       ↓
Add Anti-CSRF Token
       ↓
Remove / Modify Token
       ↓
Server Rejects Request
       ↓
PASS
```

### Authentication

``` text
Repeated Login Attempts
       ↓
Rate Limiting / MFA
       ↓
Automated Attempts Restricted
       ↓
PASS
```

------------------------------------------------------------------------

# 11. Evidence and Screenshots

The supplied Security Testing Report contains screenshots documenting
the major laboratory activities, including:

-   **SQL Injection:** normal query behavior, Boolean injection, table
    enumeration, column enumeration, and credential extraction evidence.
-   **Reflected XSS:** controlled script reflection.
-   **Stored XSS:** stored test message and resulting browser alert.
-   **DOM-Based XSS:** DVWA DOM module and URL-controlled input testing.
-   **Brute Force:** DVWA login page, captured Burp request, Intruder
    configuration, payload list, attack results, and successful
    controlled authentication.

The screenshots should be placed in the repository's `screenshots/`
directory and referenced from the relevant project documentation.

------------------------------------------------------------------------

# 12. Learning Outcomes

This project provided practical exposure to:

-   Web application vulnerability assessment
-   SQL Injection testing and database enumeration
-   XSS vulnerability analysis
-   Client-side DOM security concepts
-   CSRF testing methodology
-   HTTP request interception and analysis
-   Burp Suite Intruder
-   Authentication attack simulation
-   Secure coding and remediation concepts
-   Post-remediation verification
-   Security reporting and evidence collection

The Brute Force section specifically documents learning around attack
methodology, HTTP request analysis/manipulation, and practical use of
Burp Suite Intruder.

------------------------------------------------------------------------

# 13. Key Security Takeaways

The assessment demonstrates several recurring secure-development
principles:

1.  **Treat all user input as untrusted.**
2.  **Use parameterized database queries instead of string
    concatenation.**
3.  **Apply context-aware output encoding for XSS prevention.**
4.  **Use safe DOM APIs when processing client-side data.**
5.  **Protect state-changing requests with server-side CSRF
    validation.**
6.  **Apply rate limiting and MFA to authentication workflows.**
7.  **Use secure password hashing rather than weak password-hashing
    schemes.**
8.  **Hide sensitive database/application errors from end users.**
9.  **Apply least privilege to database accounts.**
10. **Retest vulnerabilities after remediation.**

------------------------------------------------------------------------

------------------------------------------------------------------------

# 15. Responsible Use

This repository is an **educational cybersecurity project**.

All testing techniques documented here must only be performed against:

-   Systems you own
-   Systems for which you have explicit authorization
-   Purpose-built vulnerable training environments such as DVWA

Unauthorized security testing may violate organizational policies and
applicable laws.

Use this repository to learn, practice, document, and improve defensive
security skills in controlled environments.

------------------------------------------------------------------------

## Project Status

**Assessment completed:** September 11, 2026\
**Environment:** Isolated VMware Cybersecurity Lab\
**Target:** DVWA\
**Focus:** SQLi, XSS, CSRF, and Authentication Security\
**Primary outcome:** Vulnerability demonstration, impact analysis,
mitigation documentation, and remediation verification

