#!/bin/sh

ln -s /config /root/.config/rclone

chmod +x /root/.aria2/autoupload.sh
chmod +x /root/.aria2/delete.aria2.sh
chmod +x /root/.aria2/delete.sh


echo "rpc-secret=${RPC_SECRET:-}" >> /etc/aria2.conf

echo > /root/.aria2/aria2.session

rclone config --config /config/rclone.conf & aria2c --conf-path=/root/.aria2/aria2.conf