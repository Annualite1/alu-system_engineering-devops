# Load Balancer

Scripts to double the number of web servers and place them behind an HAProxy load balancer.

## Files

| File | Description |
|------|-------------|
| `0-custom_http_response_header` | Installs Nginx on a fresh Ubuntu machine and adds a custom `X-Served-By` response header whose value is the server's hostname. Run on both `web-01` and `web-02`. |
| `1-install_load_balancer` | Installs and configures HAProxy on `lb-01` to distribute traffic between `web-01` and `web-02` using a round-robin algorithm. HAProxy can be managed via its init script. |

## Requirements

- Ubuntu servers: `web-01`, `web-02` and `lb-01`
- Hostnames set to `[STUDENT_ID]-web-01` and `[STUDENT_ID]-web-02`
- `sudo` access on each server

## Usage

### 1. Web servers (`web-01` and `web-02`)

```bash
./0-custom_http_response_header
```

Check the header:

```bash
curl -sI <web-server-ip> | grep X-Served-By
```

Expected output (the value is the server's hostname):

```
X-Served-By: 03-web-01
```

### 2. Load balancer (`lb-01`)

Edit `1-install_load_balancer` and replace `WEB_01_IP` and `WEB_02_IP` with the IP addresses of your web servers, then run:

```bash
./1-install_load_balancer
```

Manage HAProxy with the init script:

```bash
sudo service haproxy status
sudo service haproxy restart
```

Check the round-robin behaviour by running this several times; the header should alternate between the two servers:

```bash
curl -sI <lb-01-ip> | grep X-Served-By
```

## Notes

- `SC2154` is ignored for `shellcheck` in `0-custom_http_response_header`, because `$hostname` is an Nginx variable, not a shell variable.
- Both scripts are safe to re-run: the header and the HAProxy block are only added once.
