class jenkins {
  package { 'maven':
    ensure => present,
  }
  package { 'alien':
    ensure => present,
  }
}

