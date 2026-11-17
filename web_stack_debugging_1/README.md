# Web stack debugging #1

Debugging exercises for a web stack running on Ubuntu 20.04 LTS.

## Tasks

### 0. Nginx likes port 80

`0-nginx_likes_port_80` is a Bash script that makes Nginx run and listen on
port 80 of all active IPv4 IPs.

**Cause:** `/etc/nginx/sites-enabled/default` was not linked to the default
site config, so no server block listened on port 80.

**Fix:** recreate the symlink to `/etc/nginx/sites-available/default`, then
restart Nginx.
