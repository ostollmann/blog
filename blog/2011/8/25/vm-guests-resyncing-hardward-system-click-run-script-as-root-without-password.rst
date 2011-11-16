public: yes
tags: [linux, scripts, vmware]

VM guests: re-syncing hardware-/system clock (run sync script as root without password)
=======================================================================================

So I have this problem with a virtual dev box that when I suspend the machine and then un-suspend it again the system time will be wrong. The hardware clock is obviously still right (as it is controlled and thus adjusted by the VM host).

This is not a huge problem as you can simply resync the system clock using the hwclock. This is quite easy and can be done with this command:

.. sourcecode:: bash

    hwclock --hctosys

The problem is just that I don.t want to do this manually every time I login. So I thought I would just add it to my .bash_profile/.bashrc/.*rc and then have it sync the clock everytime I login.

*Note: the first thought was to resync it on a restart, but because I just suspend the guest it is hardly ever restarted.*

Now the problem was that the hwclock program must be run as the superuser. So how can I run a script as the superuser without having to login as the superuser every time?

Well it.s not too hard. Simply add the following line to the sudoers file:

.. sourcecode:: bash

    ost ALL=(ALL) NOPASSWD: /home/ost/bin/sync_clock

This allows you to run this application as root without having to enter the password. You can try it by running it like this:

.. sourcecode:: bash

    sudo ./bin/sync_clock

It should not ask you for a password now (note that if you must still prepend the command with **sudo**).

*Note: sync_clock is a simple bash script that runs the hwclock sync application and is called from .bash_profile or .bashrc (depending on your system, I have it in .bashrc on arch).*
