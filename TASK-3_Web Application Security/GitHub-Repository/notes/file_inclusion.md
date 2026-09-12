1. Objective and Scope
This section documents the execution and analysis of a Local File Inclusion (LFI) attack against a vulnerable file-loading function in the web application (Mutillidae on the Metasploitable2 VM). The objective was to successfully exploit the vulnerability to read sensitive local system files from the server's file system and to document the necessary secure coding principles for mitigation.

2. Vulnerability Description and Execution
Vulnerability Discovered
The application contains a File Inclusion vulnerability because it takes a file name directly from a URL parameter (e.g., file=) and loads that file into the web page without properly sanitizing the input or checking the file's location. This allows an attacker to manipulate the file path.

Exploitation Process
The exploit was performed in a low-security environment to demonstrate the weakness of the application's file handling:

Target Identification: The vulnerable URL parameter was identified as being responsible for loading content, typically within a path like index.php?page=include.php&file=....

Payload Construction: The goal was to use the directory traversal sequence (../) to escape the web application's root directory and navigate to the operating system's root directory. The target sensitive file was the /etc/passwd file, which contains a list of all user accounts on the Linux server.

Successful LFI Payload: The following payload was submitted via the URL to access the target file:

index.php?page=include.php&file=../../../../etc/passwd
Successful Data Extraction (Evidence)
The payload successfully navigated the file system and forced the application to read and display the entire contents of the /etc/passwd file directly on the web page.

Evidence Snapshot (Partial Content):

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/bin/nologin
sys:x:3:3:sys:/dev:/usr/bin/nologin
...
msfadmin:x:1000:1000:msfadmin:/home/msfadmin:/bin/bash
Impact: The successful extraction of the /etc/passwd file proves that an attacker can read nearly any unprivileged file on the server. This is considered a High to Critical vulnerability, as it allows for significant information gathering (user accounts, configuration files, source code).

3. Mitigation and Prevention (Whitelisting and Filtering)
The solution to prevent Local File Inclusion is to implement strict controls on what file paths the application can accept and process.

Required Mitigation Principles
Whitelisting (The Strongest Defense):

The application should maintain an explicit Whitelist of acceptable, predefined file names that can be included.

The application should only allow the user to select from this list, rather than accepting a raw file path. Any request for a file not on the list must be rejected.

Input Filtering:

All user input passed to a file system function must be strictly filtered to prevent directory traversal sequences like ../ and ..\\. The server should strip these characters completely before the path is processed.

Input should also be validated to ensure it only contains necessary, safe characters (e.g., alphanumeric characters for a file name).

This ensures the application only includes files from an approved list and can never be tricked into accessing system files outside of the defined web root.