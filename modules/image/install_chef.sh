echo "deb http://apt.cloudscaling.com:3142/cloudscaling natty main" > /etc/apt/sources.list.d/cloudscaling.list
echo "deb http://apt.cloudscaling.com:3142/opscode natty-0.10 main" > /etc/apt/sources.list.d/opscode.list
wget http://apt.cloudscaling.com/apt@cloudscaling.com.gpg.key -O - | apt-key add -
wget http://apt.opscode.com/packages@opscode.com.gpg.key -O - | apt-key add -
export DEBIAN_FRONTEND=noninteractive
echo "chef  chef/chef_server_url    string"  > /tmp/chef.seed
debconf-set-selections /tmp/chef.seed
apt-get update && apt-get install -y ruby1.9.2-full chef
service chef-client stop
update-rc.d chef-client disable
#/usr/bin/chef-solo
