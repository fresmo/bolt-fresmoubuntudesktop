# == Class: fresmoubuntudesktop
#
# Setup my personal ubuntu desktop
#
# === Authors
#
# Marco Frese <marco.frese84@gmail.com>
#
#
class fresmoubuntudesktop (
  String[2] $user     = 'mfrese',
  Boolean   $lenovo   = true,
) {
  include fresmoubuntudesktop::profile::kernel
  include fresmoubuntudesktop::profile::user_misc
  include fresmoubuntudesktop::profile::software
  #include fresmoubuntudesktop::profile::system
}
