# == Class: fresmoubuntudesktop::profile::software::nextcloud
#
class fresmoubuntudesktop::profile::software::nextcloud {

  exec { 'add-apt-repository ppa:nextcloud-devs/client && apt-get update':
    user    => 'root',
    unless  => "test -f /etc/apt/sources.list.d/nextcloud-devs-ubuntu-client-${::lsbdistcodename}.list",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin',
    creates => "/etc/apt/sources.list.d/nextcloud-devs-ubuntu-client-${::lsbdistcodename}.list",
  }
  -> package { 'nextcloud-client':
    ensure => installed,
  }
}
