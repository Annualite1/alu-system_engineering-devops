\# Firewall



This directory contains tasks about configuring a firewall with `ufw` on an Ubuntu server.



\## Tasks



\### 0. Block all incoming traffic but

\*\*File:\*\* `0-block\_all\_incoming\_traffic\_but`



Installs and configures `ufw` on web-01 so that all incoming traffic is blocked except these TCP ports:



| Port | Service |

|------|---------|

| 22   | SSH     |

| 80   | HTTP    |

| 443  | HTTPS (SSL) |



The file lists the exact commands used:



&#x20;   sudo apt-get update

&#x20;   sudo apt-get install -y ufw

&#x20;   sudo ufw default deny incoming

&#x20;   sudo ufw default allow outgoing

&#x20;   sudo ufw allow 22/tcp

&#x20;   sudo ufw allow 80/tcp

&#x20;   sudo ufw allow 443/tcp

&#x20;   sudo ufw enable

&#x20;   sudo ufw status verbose



\## Notes



\- Port 22 is allowed \*\*before\*\* `ufw enable`, so the SSH connection is not locked out.

\- Verify the rules with `sudo ufw status verbose`.

\- Test open and closed ports from web-02 (not the school network) with `telnet <IP> <PORT>`.

