class unicorn(
  $user,
  $appname,
  $approot,
){

  # Create init script for unicorn service
  file { 'unicorn_init':
    path    => "/etc/init.d/unicorn",
    ensure  => file,
    mode    => 0755,
    content => template('unicorn/init_script.erb'),
  }

  # Create run-level files for unicorn service
  # and start the service.
  service { "unicorn":
    enable => true,
    ensure => "running",
    require => File['/etc/init.d/unicorn'],
  }
}
