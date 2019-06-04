# == Class: fresmoubuntudesktop::profile::software::spotify

class fresmoubuntudesktop::profile::software::spotify {
  apt::source { 'spotify':
    location => 'http://repository.spotify.com',
    release  => 'stable',
    repos    => 'non-free',
    key      => {
      'id'     => '931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90',
      'server' => 'hkp://keyserver.ubuntu.com:80',
    },
  }
  -> package { 'spotify-client':
          ensure => installed,
  }
}
