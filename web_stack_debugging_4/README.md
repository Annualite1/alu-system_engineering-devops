# Web stack debugging #4

Puppet manifest that fixes an Nginx web server failing requests under load
(ApacheBench: `ab -c 100 -n 2000 localhost/`) by raising the `ULIMIT`
in `/etc/default/nginx` and restarting Nginx.

## Files

- `0-the_sky_is_the_limit_not.pp` - raises the open file limit and restarts Nginx

## Usage

```
puppet apply 0-the_sky_is_the_limit_not.pp
```
