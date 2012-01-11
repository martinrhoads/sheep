#!/bin/bash -x

# sudo setup
# note: do not use tabs here, it autocompletes and borks the sudoers file
cat <<EOF > /etc/sudoers
root    ALL=(ALL)    ALL
%wheel    ALL=(ALL)    NOPASSWD: ALL
EOF

# set up user accounts
passwd<<EOF
vagrant
vagrant
EOF
useradd -m -G wheel -r vagrant
passwd -d vagrant
passwd vagrant<<EOF
vagrant
vagrant
EOF

# make sure ssh is allowed
echo "sshd:	ALL" > /etc/hosts.allow

# and everything else isn't
echo "ALL:	ALL" > /etc/hosts.deny

# make sure sshd starts
sed -i 's:^DAEMONS\(.*\))$:DAEMONS\1 sshd):' /etc/rc.conf

# update pacman
pacman -Syy
pacman -S --noconfirm pacman

# upgrade pacman db
pacman-db-upgrade
pacman -Syy

pacman -S --noconfirm ruby git yajl

# install some packages
#gem install --no-ri --no-rdoc chef

# host-only networking
cat >> /etc/rc.local <<EOF
# enable DHCP at boot on eth0
# See https://wiki.archlinux.org/index.php/Network#DHCP_fails_at_boot
dhcpcd eth0
EOF

# install yaourt
wget http://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar -xzvf package-query.tar.gz
cd package-query
makepkg -s --asroot --install --noconfirm
cd ..
wget http://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar -xzvf yaourt.tar.gz
cd yaourt
makepkg -s --asroot --install --noconfirm

# clean out pacman cache
pacman -Scc<<EOF
y
y
EOF

# Upgrade to the latest!
#pacman -Syu --noconfirm
