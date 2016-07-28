class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice': }
  users::managed_user { 'chen':
    group => 'admin',
  }
  users::managed_user { 'bob': }
  group { 'admin':
    ensure => present,
  }
}
