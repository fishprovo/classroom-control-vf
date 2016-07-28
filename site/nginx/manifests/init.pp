class nginx {

  $pkg = 'nginx'
  $etc_dir = '/etc/nginx'
  $fowner = 'root'
  $fgroup = 'root'
  $docroot = '/var/www'
  $server_block = "${etc_dir}/conf.d"
  $log_dir = '/var/log/nginx'
  $service = 'nginx'
  $run_as  = 'nginx'
  
  
  File {
    owner => $fowner,
    group => $fgroup,
    mode  => '0644',
  }
  package { $pkg:
    ensure => present,
  }
  file { $docroot:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${etc_dir}/nginx.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package[$pkg],
    notify  => Service[$service],
  }
  file { $server_block:
    ensure => directory,
  }
  file { "${server_block}/default.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package[$pkg],
    notify  => Service[$service],
  }
  service { $service:
    ensure    => running,
    enable    => true,
  }
}
