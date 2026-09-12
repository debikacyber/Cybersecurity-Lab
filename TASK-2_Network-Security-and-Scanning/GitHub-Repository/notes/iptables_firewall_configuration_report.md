# Report: Basic Firewall Configuration with iptables

**Date:** September 10, 2026
**Analyst:** Debika Goswami
**Objective:** To configure a basic "default deny" firewall policy using `iptables`, allow specific services, and implement a dynamic rule to detect and block a network port scan.

---

## 1. Tools Used 🛠️

* **iptables:** The command-line utility for configuring the Linux kernel firewall (Netfilter).
* **nmap:** A network scanning tool used to verify the effectiveness of the port scan blocking rules.

---

## 2. Methodology and Procedures

The configuration and testing were performed in a series of distinct phases.

### ### Phase 1: Establishing a "Default Deny" Policy

The initial state of the firewall was confirmed to be a "default accept" policy, where all traffic was permitted. A more secure baseline was established with the following steps:

1.  **Set Default Policy to DROP:** The default policy for the `INPUT` chain was changed to `DROP`. This ensures that any traffic not explicitly allowed by a rule is blocked.
    ```bash
    sudo iptables -P INPUT DROP
    ```
2.  **Allow Established Connections:** A crucial rule was added to permit return traffic for connections initiated by the host machine.
    ```bash
    sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    ```
3.  **Allow Localhost Traffic:** Communication on the loopback interface (`lo`) was permitted to ensure local services could function correctly.
    ```bash
    sudo iptables -A INPUT -i lo -j ACCEPT
    ```
This created a secure baseline where the firewall was locked down, only allowing essential communication.

### ### Phase 2: Port Scan Detection and Mitigation

To dynamically block malicious scanning activity, a set of rules using the `recent` module was implemented.

1.  **Cleanup:** All existing rules were flushed to ensure a clean environment for the new ruleset.
    ```bash
    sudo iptables -F
    ```
2.  **Rule Implementation:** A custom chain named `PORTSCAN` was created to contain the detection logic. All new incoming TCP connections were directed to this chain. The rules were configured to track new connections from each source IP. If a single IP made more than 5 connection attempts within a 60-second window, it was flagged and subsequent packets from it were dropped.
    ```bash
    # Create the custom chain
    sudo iptables -N PORTSCAN
    # Send new connections to the chain
    sudo iptables -A INPUT -p tcp --syn -j PORTSCAN
    # Identify and drop the scanner
    sudo iptables -A PORTSCAN -m recent --name SCAN --update --seconds 60 --hitcount 5 -j DROP
    # Add new IPs to the tracking list
    sudo iptables -A PORTSCAN -m recent --name SCAN --set -j ACCEPT
    ```

### ### Phase 3: Verification with `nmap`

The effectiveness of the port scan blocking rules was tested by simulating a scan against the local machine.

* **Command Used:** `nmap -v 127.0.0.1`
* **Observed Result:** The `nmap` scan began successfully but was thwarted after a few seconds. The `iptables` rules correctly identified the rapid connection attempts, added the source IP to the blocklist, and began dropping subsequent packets. The `nmap` output showed the remaining ports as `filtered`, confirming the block was successful.

### ### Phase 4: System Cleanup

Upon completion of the exercise, the firewall was restored to its default state to prevent unintended network issues. All rules were flushed, the custom `PORTSCAN` chain was deleted, and the default policies for all built-in chains were reset to `ACCEPT`.

---

## 3. Conclusion and Key Takeaways

This exercise successfully demonstrated the configuration of a robust firewall policy using `iptables`.

1.  **"Default Deny" is Best Practice:** The most significant takeaway is the importance of a default-deny security stance. By blocking everything and only allowing what is explicitly needed, the potential attack surface is drastically reduced.
2.  **Stateful Rules are Powerful:** `iptables` is more than just a static port blocker. By using modules like `recent`, it's possible to create dynamic, behavior-based rules that can respond to threats like port scans in real-time.
3.  **Verification is Crucial:** Implementing security rules is only half the battle. Testing them with tools like `nmap` is essential to verify they are working as intended.
