#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# https://computingforgeeks.com/setup-glusterfs-storage-with-heketi-on-centos-server/

groupadd --system heketi
useradd -s /sbin/nologin --system -g heketi heketi
mkdir -p /var/lib/heketi /etc/heketi /var/log/heketi

cp -fv ./etc/heketi.json /etc/heketi
for i in dm_snapshot dm_mirror dm_thin_pool; do
  modprobe $i
done
ssh-keygen -f /etc/heketi/heketi_key -t rsa -N ''
chown heketi:heketi /etc/heketi/heketi_key*

for i in gluster00 gluster01 gluster02; do
  ssh-copy-id -i /etc/heketi/heketi_key.pub root@$i
done
# /usr/bin/ssh -i /etc/heketi/heketi_key root@gluster01
cp -fv ./extras/systemd/heketi.service /etc/systemd/system/heketi.service
chown -R heketi:heketi /var/lib/heketi /var/log/heketi /etc/heketi
systemctl daemon-reload
systemctl enable --now heketi
systemctl status heketi

cp -fv ./extras/systemd/heketi.env /etc/heketi/heketi.env
cp -fv ./topology.json /etc/heketi/topology.json
heketi-cli topology load --json=/etc/heketi/topology.json

heketi-cli node list
# heketi-cli node info 56a8a65bff9461296f4ce8cba03481f7
heketi-cli volume create --size=1
# heketi-cli volume create --durability=none --size=1

heketi-cli topology info