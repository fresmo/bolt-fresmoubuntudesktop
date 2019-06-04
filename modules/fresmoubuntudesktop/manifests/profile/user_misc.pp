# == Class: fresmoubuntudesktop::profile::user_misc
#
# Setup my personal ubuntu desktop
#
# === Authors
#
# Marco Frese <marco.frese84@gmail.com>
#
#

class fresmoubuntudesktop::profile::user_misc (
  String $user = $fresmoubuntudesktop::user,
){


  File {
    owner => $user,
    group => $user,
  }

  file { "/home/${user}/.tmux.conf":
    ensure => file,
    mode => '0644',
    source  => "puppet:///modules/${module_name}/tmux.conf",
  }
  -> package { 'tmux':
    ensure => installed,
  }


  file { "/home/${user}/.screenrc":
    ensure => file,
    mode => '0644',
    source  => "puppet:///modules/${module_name}/screenrc",
  }
  -> package { 'screen':
      ensure => installed,
  }


  file { "/home/${user}/src":
    ensure => directory,
  }

  file { "/home/${user}/bin":
    ensure => directory,
  }

  file { "/home/${user}/scripts":
    ensure => directory,
  }

  file { "/home/${user}/scripts/git-prompt.sh":
    ensure => file,
    mode => '0774',
    source  => "puppet:///modules/${module_name}/git-prompt.sh",
  }

  file { "/home/${user}/.bashrc":
    ensure => file,
    mode => '0644',
    source  => "puppet:///modules/${module_name}/.bashrc",
  }

  file { "/root/.bashrc":
    ensure => file,
    mode => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/${module_name}/bashrc",
  }

# dconf dump /org/gnome/terminal/ > terminal_settings_backup.txt
# dconf load /org/gnome/terminal/ < gnome_terminal_settings_backup.txt

  file { "/home/${user}/src/terminal_settings_backup.txt":
    ensure => file,#
    mode => '0644',
    source  => "puppet:///modules/${module_name}/terminal_settings_backup.txt",
  }
# TODO: Exec doesnt work. Manual load of terminal setting required.
  exec { 'restore-teminal-setting':
    command     => "/usr/bin/dconf load /org/gnome/terminal/ < /home/${user}/src/terminal_settings_backup.txt",
    refreshonly => true,
    require     => File["/home/${user}/src/terminal_settings_backup.txt"],
  }


# Create terminator user config directory
    file { "/home/${user}/.config/terminator":
      ensure  => directory,
    }

# set terminator config file
    file { "/home/${user}/.config/terminator/config":
      ensure  => file,
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/terminator_config",
      require => Package['terminator'],
    }


}
