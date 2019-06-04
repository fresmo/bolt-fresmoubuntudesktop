# == Class: fresmoubuntudesktop::profile::software::vim
#
class fresmoubuntudesktop::profile::software::vim {

  File {
    owner => $fresmoubuntudesktop::user,
    group => $fresmoubuntudesktop::user,
  }

  ensure_resource('package', [
      'vim',
      'vim-gtk3',
      'vim-syntastic',
      'vim-python-jedi',
      'exuberant-ctags'
      ],
  {'ensure' => 'present'}
  )

  alternatives { 'editor':
    path     => '/usr/bin/vim.basic',
    require  => Package['vim']
  }
  file { "/home/${fresmoubuntudesktop::user}/.vimrc":
    ensure  => file,
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/vimrc"
  }
  file { "/home/${fresmoubuntudesktop::user}/.vim":
    ensure   => directory,
    mode     => '0755',
    source   => "puppet:///modules/${module_name}/vim",
    recurse  => true,
  }

# Setup vim Vundle configuration
  exec { "git vundle":
    command => "/usr/bin/git clone https://github.com/VundleVim/Vundle.vim.git /home/$fresmoubuntudesktop::user/.vim/bundle/Vundle.vim",
    user    => $fresmoubuntudesktop::user,
    require => [
      Package["git"],
      Package["vim"],
      File["/home/$fresmoubuntudesktop::user/.vimrc"],
      File["/home/$fresmoubuntudesktop::user/.vim/"]
      ]
  }

  # Install Vundle plugins
  exec { "vundle bundle install":
    command => "/usr/bin/vim +BundleInstall +qall",
    user    => $fresmoubuntudesktop::user,
    require => Exec["git vundle"]
  }

# ToDo: Execute 'PluginInstall' in vim command mode

}
