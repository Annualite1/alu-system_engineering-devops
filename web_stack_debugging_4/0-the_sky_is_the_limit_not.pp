# Fixes nginx failed requests under load by raising the open file limit (ULIMIT)
exec { 'fix--for-nginx':
  command  => 'sed -i "s/15/4096/" /etc/default/nginx; service nginx restart',
  provider => 'shell',
  path     => ['/usr/local/bin', '/bin', '/usr/bin', '/sbin'],
}
