#!/bin/sh
chmod +x /root/.aria2/autoupload.sh
chmod +x /root/.aria2/delete.aria2.sh
chmod +x /root/.aria2/delete.sh
echo > /root/.aria2/aria2.session

cat >> /etc/aria2.conf <<EOF

rpc-secret=${RPC_SECRET:-}

EOF

rclone config ${RCLONE_OPTS} & aria2c --conf-path=/root/.aria2/aria2.conf