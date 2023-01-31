#!/bin/sh
# CentOS 7 install
cd /tmp
echo "*           Welcome to Script build Fusion_PBX_System        		*"
yum update -y 
yum groupinstall -y 'Development Tools'
yum install -y epel-release
yum update -y
yum install -y git autoconf automake libtool gcc-c++ libuuid-devel zlib-devel libjpeg-devel ncurses-devel openssl-devel sqlite-devel curl-devel pcre-devel speex-devel ldns ldns-devel libedit-devel gtk+-devel gtk2-devel yasm-devel lua-devel opus-devel e2fsprogs-devel libyuv-devel lua-devel libsndfile-devel libshout-devel lame-devel libvpx-devel opusfile libbroadvoice-dev libtiff-*
echo '[irontec]
name=Irontec RPMs repository
baseurl=http://packages.irontec.com/centos/$releasever/$basearch/' > /etc/yum.repos.d/irontec.repo
rpm --import http://packages.irontec.com/public.key
yum install sngrep -y
mkdir /tmp/build
cd  /tmp/build
git clone https://github.com/freeswitch/sofia-sip.git
git clone https://github.com/freeswitch/spandsp.git
cd sofia-sip
./bootstrap.sh &&./configure && make && make install
cd ..
cd spandsp
./bootstrap.sh &&./configure && make && make install
echo "signalwire" > /etc/yum/vars/signalwireusername
echo "pat_9GLDnLG9uxxH524XFp4nM4Wk" > /etc/yum/vars/signalwiretoken
yum install -y https://$(< /etc/yum/vars/signalwireusername):$(< /etc/yum/vars/signalwiretoken)@freeswitch.signalwire.com/repo/yum/centos-release/freeswitch-release-repo-0-1.noarch.rpm epel-release
yum install -y freeswitch-config-vanilla freeswitch-lang-* freeswitch-sounds-*
systemctl enable freeswitch
systemctl start freeswitch
systemctl restart freeswitch
systemctl status freeswitch
yum install wget -y
wget -O - https://raw.githubusercontent.com/fusionpbx/fusionpbx-install.sh/master/centos/pre-install.sh | sh
vi /usr/src/fusionpbx-install.sh/centos/resources/finish.sh
vi /usr/src/fusionpbx-install.sh/centos/install.sh
cd /usr/src/fusionpbx-install.sh/centos && ./install.sh
