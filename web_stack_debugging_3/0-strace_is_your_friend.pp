# Fixes the Apache 500 error by correcting a typo (.phpp -> .php) in WordPress
exec { 'fix-wordpress':
  command => 'sed -i "s/phpp/php/g" /var/www/html/wp-settings.php',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'grep -q "phpp" /var/www/html/wp-settings.php',
}
