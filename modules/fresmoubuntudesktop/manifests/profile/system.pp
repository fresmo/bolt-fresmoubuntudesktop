# == Class: fresmoubuntudesktop::profile::system
#
# Setup my personal ubuntu desktop
#
# === Authors
#
# Marc Schoechlin <marc.schoechlin@256bit.org>
#
#

class fresmoubuntudesktop::profile::system {

  # Disable capslock
  augeas{ 'disable_capslock':
    context =>  '/files/etc/default/keyboard',
    changes =>  "set XKBOPTIONS 'ctrl:nocaps'",
    onlyif  =>  "match XKBOPTIONS not_include 'ctrl:nocaps'",
  }

  # Disable crash reporter
  augeas{ 'disable_apport':
    context =>  '/files/etc/default/apport',
    changes =>  'set enabled \'0\'',
  }

  # configure sudo
  file { '/etc/sudoers.d/':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
  }

  # Install a tiny script to update the system
  file { '/usr/local/sbin/ubuntu-update':
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/${module_name}/ubuntu-update",
  }
  file { '/etc/sudoers.d/ubuntu-update':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "
     ${fresmoubuntudesktop::user} ALL = NOPASSWD:/usr/local/sbin/ubuntu-update
    "
  }
  file { '/etc/sudoers.d/puppet':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "
${fresmoubuntudesktop::user} ALL = NOPASSWD:/opt/puppetlabs/bin/puppet
${fresmoubuntudesktop::user} ALL = NOPASSWD:/usr/local/sbin/puppet
    "
  }
  # Install a tiny script to update the system
  file { '/usr/sbin/passwd-sync':
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/${module_name}/passwd-sync",
  }
  -> exec { "/usr/sbin/passwd-sync ${fresmoubuntudesktop::user} root set":
    user   => 'root',
    unless => "/usr/sbin/passwd-sync ${fresmoubuntudesktop::user} root check",
    path   => '/usr/bin:/usr/sbin:/bin',
  }

  # Apparmor
  package { 'apparmor-utils':
    ensure => installed,
  }

}
