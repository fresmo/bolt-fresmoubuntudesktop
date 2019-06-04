# == Class: fresmoubuntudesktop::profile::software::tlp
#
class fresmoubuntudesktop::profile::software::tlp {

  apt::source { "linrunner-ubuntu-tlp-${::lsbdistcodename}":
    location => 'http://ppa.launchpad.net/linrunner/tlp/ubuntu',
    release  => "${::lsbdistcodename}",
    repos    => 'main',
    key      => {
      'id'     => '2042F03C5FABD0BA2CED40412B3F92F902D65EFF',
      'server' => 'hkp://keyserver.ubuntu.com:80',
    },
  }
  -> package { ['tlp', 'tlp-rdw']:
          ensure => latest,
  }

  if $fresmoubuntudesktop::lenovo {
    package { ['tp-smapi-dkms', 'acpi-call-dkms']:
      ensure => installed,
    }
  }
    exec { 'start-tlp':
      command     => '/usr/sbin/tlp start',
      refreshonly => true,
    }

}
