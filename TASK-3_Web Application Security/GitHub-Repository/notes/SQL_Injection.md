1. Objective and Scope
This section documents the execution and analysis of a UNION SELECT SQL Injection attack against a vulnerable web application (Mutillidae on the Metasploitable2 VM). The objective was to successfully exploit the vulnerability to extract sensitive database information (usernames and passwords) and to document the secure coding practice required for mitigation.

2. Vulnerability Description and Execution
Vulnerability Discovered
The target web application's User Lookup functionality was identified as vulnerable to SQL Injection due to improper sanitization of user-supplied input. The application was performing direct string concatenation when building the SQL query, allowing an attacker to manipulate the query structure.

Exploitation Process
The exploit was performed in a low-security environment to demonstrate the weakness:
Vulnerability Confirmation: A single quote (') was submitted in the User ID field, which resulted in a verbose SQL error message, confirming the field was vulnerable.
Column Counting: The ORDER BY clause was used to determine the correct number of columns selected by the original query. The final working number was determined to be three (3) columns.
Data Extraction Payload (UNION SELECT): The following payload was crafted and submitted to bypass authentication and extract all user credentials from the database.
-1 UNION SELECT 1, username, password FROM users --


Successful Data Extraction (Evidence)
The payload successfully forced the application to append a new query (SELECT username, password FROM users) to the original SQL statement. The output on the web page returned all credentials stored in the database.

User ID	Username	Password (Hashed)
1	admin	5f4dcc3b5aa765d61d8327deb882cf99 (md5: 'password')
2	john	5f4dcc3b5aa765d61d8327deb882cf99 (md5: 'password')
3	greg	5f4dcc3b5aa765d61d8327deb882cf99 (md5: 'password')
4	paul	5f4dcc3b5aa765d61d8327deb882cf99 (md5: 'password')
5	jane	5f4dcc3b5aa765d61d8327deb882cf99 (md5: 'password')


3. Mitigation and Prevention (Prepared Statements)
The solution to prevent this critical SQL Injection vulnerability is to stop treating user input as executable code. This is achieved through Prepared Statements.

Vulnerable Code Structure (Demonstrated by Low-Security Mode)
The application's vulnerable code uses direct string concatenation, creating the exploit:

$user_input = $_GET['user_id'];
$query = "SELECT username, password FROM users WHERE id = '$user_input'"; // Vulnerable
// ... executes query ...

