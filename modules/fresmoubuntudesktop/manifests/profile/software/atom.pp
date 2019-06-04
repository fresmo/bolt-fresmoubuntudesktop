# == Class: fresmoubuntudesktop::profile::software::atom

# Check fingerprint of repository:
# http://keyserver.ubuntu.com/pks/lookup?search=0x0A0FAB860D48560332EFB581B75442BBDE9E3B09&op=index

class fresmoubuntudesktop::profile::software::atom (
  Array[String] $apm_packages  = [
  'SFTP-deployment',
  'autocomplete-python',
  'busy-signal',
  'intentions',
  'language-puppet',
  'language-terraform',
  'linter',
  'linter-terraform-syntax',
  'linter-ui-default',
  'monokai-seti',
  'platformio-ide-terminal',
  'atom-beautify',
  'minimap',
  ],
){
  apt::source { 'atom':
    location => '[arch=amd64] https://packagecloud.io/AtomEditor/atom/any/',
    release  => 'any',
    repos    => 'main',
    key      => {
      'id'     => '0A0FAB860D48560332EFB581B75442BBDE9E3B09',
      'server' => 'hkp://keyserver.ubuntu.com:80',
    },
  }
  -> package { 'atom':
          ensure => latest,
  }

  file { "/home/${fresmoubuntudesktop::user}/bin/apm_install_packages":
    ensure    => file,
    owner     => $fresmoubuntudesktop::user,
    group     => $fresmoubuntudesktop::user,
    mode      => '0774',
    content   => template("${module_name}/apm_install_packages_sh.erb"),
    notify    => Exec['apm-install-packages'],
    require   => [ Package['atom'] ],
  }

  exec { 'apm-install-packages':
    user        => $fresmoubuntudesktop::user,
    command     => "/bin/bash /home/${fresmoubuntudesktop::user}/bin/apm_install_packages",
    refreshonly => true,
    require     => File["/home/${fresmoubuntudesktop::user}/bin/apm_install_packages"],
  }

}
