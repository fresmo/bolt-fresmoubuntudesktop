# == Class: fresmoubuntudesktop::profile::software
#
# Setup my personal ubuntu desktop
#
# === Authors
#
# Marco Frese <marco.frese84@gmail.com>
#
#

class fresmoubuntudesktop::profile::software (
  Array[String] $packages_additional  = [],
  Array[String] $packages_exclude     = [],
  Boolean $nextcloud                  = true,
  Boolean $vim                        = true,
  Boolean $spotify                    = true,
  Boolean $atom                       = true,
  Boolean $snaps                      = true,
  Boolean $tlp                        = true,
  Boolean $ansible                    = true,
  Boolean $libreoffice                = true,
  Boolean $virtualbox                 = true,
  Boolean $vagrant                    = true,

){

  if ($nextcloud){
    include fresmoubuntudesktop::profile::software::nextcloud
  }
  if ($vim){
    include fresmoubuntudesktop::profile::software::vim
  }
  if ($spotify){
    include fresmoubuntudesktop::profile::software::spotify
  }
  if ($atom){
    include fresmoubuntudesktop::profile::software::atom
  }
  if ($snaps){
    include fresmoubuntudesktop::profile::software::snaps
  }
  if ($tlp){
    include fresmoubuntudesktop::profile::software::tlp
  }


########### STANDARD RESOURCE DEFINITIONS ###########
  # File {
  #   owner => $user,
  #   group => $user,
  # }

########### STANDARD PACKAGE SOURCES ###########
  apt::source { "archive.ubuntu.com-fresmodesktop":
    location => 'http://archive.canonical.com/ubuntu',
    repos    => "partner",
  }

########### STANDARD PACKAGES ###########
  $default_packages = [
  'apache2-utils',
  'augeas-tools',
  'automake',
  'build-essential',
  'cifs-utils',
  'curl',
  'direnv',
  'git',
  'graphviz',
  'jq',
  'lyx',
  'nmap',
  'openssh-server',
  'openvpn',
  'pwgen',
  'python3-pip',
  'rake',
  'ruby-dev',
  'sshfs',
  'sshpass',
  'texinfo',
  'vim',
  'wireshark',
  'ubuntu-restricted-extras',
  'pandoc',
  'whois',
  'chromium-browser',
  'pass',
  'wavemon',
  'browser-plugin-freshplayer-pepperflash',
  'sysstat',
  'net-tools',
  'iotop',
  'vlc',
  'libavcodec-extra',
  'gnome-tweak-tool',
  'nload',
  'chrome-gnome-shell',
  'gnome-shell-extensions',
  'gnome-shell-extension-caffeine',
  'mtr-tiny',
  'htop',
  'caffeine',
  'ppa-purge',
  'ncdu',
  'ipcalc',
  'traceroute',
  'terminator',
  ]

  $install_packages = $default_packages + $packages_additional
  $install_packages_with_excludes = $install_packages - $packages_exclude

  ensure_resource('package', $install_packages , {'ensure' => 'present'})

########### INSTALL LIBRE OFFICE VIA PPA ###########
  if $libreoffice {
    apt::ppa { 'ppa:libreoffice/ppa': } ->
      package { [
        'libreoffice',
        'libreoffice-l10n-de',
        ]:
          ensure => latest,
      }
  }

########### INSTALL ANSiBLE VIA PPA ###########
  if $ansible {
    package { 'software-properties-common':
      ensure => latest,
    }
    apt::ppa { 'ppa:ansible/ansible': } ->
      package { 'ansible':
        ensure => latest,
      }
  }

########### INSTALL ANSiBLE VIA PPA ###########
  if $virtualbox {
    ensure_resource('package', [
      'dkms',
      'build-essential',
      ],
      {'ensure' => 'present'}
    )
    class {'virtualbox':
      version => '6.0',
    }
  }

########### INSTALL VAGRANT ###########
  if $vagrant {
    file { "/home/${fresmoubuntudesktop::user}/scripts/install_vagrant.sh":
      ensure    => file,
      owner     => $fresmoubuntudesktop::user,
      group     => $fresmoubuntudesktop::user,
      mode      => '0774',
      source    => "puppet:///modules/${module_name}/install_vagrant.sh",
    }->
    exec { 'install-vagrant':
    command     => "/bin/bash /home/${fresmoubuntudesktop::user}/scripts/install_vagrant.sh",
    refreshonly => true,
    }
  }

}
