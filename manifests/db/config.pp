# @summary StoRM DB config class
#
class storm::db::config (

  $fqdn_hostname = $storm::db::fqdn_hostname,
  $storm_username = $storm::db::storm_username,
  $storm_password = $storm::db::storm_password,
  $root_password = $storm::db::root_password,

) {

  $short_hostname = regsubst($fqdn_hostname, '^([^.]*).*$', '\1')
  notice("Short hostname: ${short_hostname} defined")

  file { '/tmp/storm_db.sql':
    ensure => present,
    source => 'puppet:///modules/storm/storm_db.sql',
  }

  file { '/tmp/storm_be_ISAM.sql':
    ensure => present,
    source => 'puppet:///modules/storm/storm_be_ISAM.sql',
  }

  mysql::db { 'storm_db':
    user     => $storm_username,
    password => $storm_password,
    host     => $fqdn_hostname,
    grant    => 'ALL',
    sql      => '/tmp/storm_db.sql',
    require  => File['/tmp/storm_db.sql'],
  }

  mysql::db { 'storm_be_ISAM':
    user     => $storm_username,
    password => $storm_password,
    host     => $fqdn_hostname,
    grant    => 'ALL',
    sql      => '/tmp/storm_be_ISAM.sql',
    require  => File['/tmp/storm_be_ISAM.sql'],
  }

  mysql_user { "${storm_username}@${short_hostname}":
    ensure        => 'present',
    password_hash => mysql::password($storm_password),
  }
  mysql_grant { "${storm_username}@${short_hostname}/storm_db.*":
    privileges => 'ALL',
    provider   => 'mysql',
    user       => "${storm_username}@${short_hostname}",
    table      => 'storm_db.*',
    require    => [Mysql::Db['storm_db'], Mysql_user["${storm_username}@${short_hostname}"]],
  }
  mysql_grant { "${storm_username}@${short_hostname}/storm_be_ISAM.*":
    privileges => 'ALL',
    provider   => 'mysql',
    user       => "${storm_username}@${short_hostname}",
    table      => 'storm_be_ISAM.*',
    require    => [Mysql::Db['storm_be_ISAM'], Mysql_user["${storm_username}@${short_hostname}"]],
  }

  mysql_user { "${storm_username}@%":
    ensure        => 'present',
    password_hash => mysql::password($storm_password),
  }
  mysql_grant { "${storm_username}@%/storm_db.*":
    privileges => 'ALL',
    provider   => 'mysql',
    user       => "${storm_username}@%",
    table      => 'storm_db.*',
    require    => [Mysql::Db['storm_db'], Mysql_user["${storm_username}@%"]],
  }
  mysql_grant { "${storm_username}@%/storm_be_ISAM.*":
    privileges => 'ALL',
    provider   => 'mysql',
    user       => "${storm_username}@%",
    table      => 'storm_be_ISAM.*',
    require    => [Mysql::Db['storm_be_ISAM'], Mysql_user["${storm_username}@%"]],
  }

  mysql_user { "${storm_username}@localhost":
    ensure        => 'present',
    password_hash => mysql::password($storm_password),
  }
  mysql_grant { "${storm_username}@localhost/storm_db.*":
    privileges => 'ALL',
    provider   => 'mysql',
    user       => "${storm_username}@localhost",
    table      => 'storm_db.*',
    require    => [Mysql::Db['storm_db'], Mysql_user["${storm_username}@localhost"]],
  }
  mysql_grant { "${storm_username}@localhost/storm_be_ISAM.*":
    privileges => 'ALL',
    provider   => 'mysql',
    user       => "${storm_username}@localhost",
    table      => 'storm_be_ISAM.*',
    require    => [Mysql::Db['storm_be_ISAM'], Mysql_user["${storm_username}@localhost"]],
  }

}
