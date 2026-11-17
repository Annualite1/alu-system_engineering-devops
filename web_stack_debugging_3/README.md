# Web stack debugging #3

Debugging a WordPress site running on a LAMP stack that returns a 500 error.

## Tasks

### 0. Strace is your friend

`0-strace_is_your_friend.pp` is a Puppet manifest that fixes the Apache 500 error.

Finding the bug: attach `strace` to an Apache worker (`strace -p <pid>`) while running `curl -sI 127.0.0.1` in another window. The trace shows Apache/PHP failing to open `/var/www/html/wp-includes/class-wp-locale.phpp`, a file name with a typo (`.phpp` instead of `.php`) referenced from `wp-settings.php`.

The manifest runs a `sed` command through an `exec` resource to replace `phpp` with `php` in `/var/www/html/wp-settings.php`. It only runs when the typo is present, so it is idempotent.

Usage:

```
puppet apply 0-strace_is_your_friend.pp
curl -sI 127.0.0.1
```
