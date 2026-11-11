# Web server

Holberton web stack project: configuring an Nginx web server on Ubuntu 16.04
with Bash scripts, and learning how DNS works.

## Files

| File | Description |
| ---- | ----------- |
| `0-transfer_file` | Transfers a file to a server with `scp` (4 parameters, strict host key checking disabled) |
| `1-install_nginx_web_server` | Installs Nginx, listening on port 80, serving "Holberton School for the win!" |
| `2-setup_a_domain_name` | Contains the root domain name pointing to web-01 via an A record |
| `3-redirection` | Configures a 301 redirect from `/redirect_me` |
| `4-not_found_page_404` | Adds a custom 404 page containing "Ceci n'est pas une page" |
| `5-design_a_beautiful_404_page.html` | A creative, designed 404 page |

## Usage

```bash
./0-transfer_file PATH_TO_FILE IP USERNAME PATH_TO_SSH_KEY
```

The other scripts run on the server itself as root (no `sudo`, no `systemctl`).
