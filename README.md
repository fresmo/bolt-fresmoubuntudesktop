Overview
=========

This is a project to deploy my desktop/laptop environment with puppet-bolt
based on  "scoopex/puppet-mscubuntudesktop". It was tested on Ubuntu 18.04.

This project is GNU GPLv3 (see LICENCE file). Contributions or forks are welcome.

Usage
======

On fresh installed system please do the following steps:

* Install environment bolt components
~~~bash
sudo ./install_bolt.sh
~~~

It will install the bolt packages from official puppetlabs-repo. Puppet-bolt
needs ruby and facter. So it will be installed too. The script will also
create some environment folders and depencies.

After the bolt installation is complete exercute a bolt script

~~~bash
sudo ./run_bolt.sh
~~~

Go and drink a coffee. It would take a little bit :)

NOTICE
=======
I tested it like remote exercution too but my idea was to save time,
anstead  configure a hole puppet environment for only local deployment.
