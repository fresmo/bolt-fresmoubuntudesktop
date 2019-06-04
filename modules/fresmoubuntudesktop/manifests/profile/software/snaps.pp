# == Class: fresmoubuntudesktop::profile::software::snaps
#
class fresmoubuntudesktop::profile::software::snaps (
  Array[String] $snaps_additional   = [],
){

  package { [
    'brave',
    'sublime-text',
    'pycharm-community',
    'telegram-desktop',
    ]:
    ensure   => latest,
    provider => snap,
  }

  file { "/home/${fresmoubuntudesktop::user}/scripts/clear_snap.sh":
    ensure  => file,
    mode    => '0774',
    owner   => $fresmoubuntudesktop::user,
    group   => $fresmoubuntudesktop::user,
    source  => "puppet:///modules/${module_name}/clean_snap.sh",
  }

}
