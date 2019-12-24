#!/bin/sh
chmod +x /root/.aria2/autoupload.sh
chmod +x /root/.aria2/delete.aria2.sh
chmod +x /root/.aria2/delete.sh
echo > /root/.aria2/aria2.session




cat > /etc/aria2.conf <<EOF
enable-rpc=true
rpc-listen-all=true
rpc-secret=${RPC_SECRET:-}
dir=${DOWNLOAD_DIR:-/downloads}
log=${DOWNLOAD_DIR:-/downloads}/aria2.log
max-concurrent-downloads=${CONCURRENT_DOWNLOADS:-4}
split=${SPLIT:-4}
max-connection-per-server=${CONNECTIONS_PER_SERVER:-4}
user-agent=${USER_AGENT:-}
file-allocation=
allow-overwrite=${ALLOW_OVERWRITE:-true}
auto-file-renaming=${AUTO_FILE_RENAMING:-false}



## '#'开头为注释内容, 选项都有相应的注释说明, 根据需要修改 ##
## 被注释的选项使用的是默认值, 建议在需要使用时再取消注释  ##

## RPC相关设置 ##

# 启用RPC, 默认:false
enable-rpc=true
# 接受所有远程请求, 默认:false
rpc-allow-origin-all=true
# 允许外部访问, 默认:false
rpc-listen-all=true
# 事件轮询方式, 取值:[epoll, kqueue, port, poll, select], 不同系统默认值不同
#event-poll=select
# RPC监听端口, 端口被占用时可以修改, 默认:6800
rpc-listen-port=6800
# 设置的RPC授权令牌, v1.18.4新增功能, 取代 --rpc-user 和 --rpc-passwd 选项
rpc-secret=godwolf
# 设置的RPC访问用户名（1.15.2以上，1.18.6以下版本）, 此选项新版已废弃, 建议改用 --rpc-secret 选项
#rpc-user=<USER>
# 设置的RPC访问密码（1.15.2以上，1.18.6以下版本）, 此选项新版已废弃, 建议改用 --rpc-secret 选项
#rpc-passwd=<PASSWD>
# 是否启用 RPC 服务的 SSL/TLS 加密,
# 启用加密后 RPC 服务需要使用 https 或者 wss 协议连接
#rpc-secure=true
# 在 RPC 服务中启用 SSL/TLS 加密时的证书文件(.pem/.crt)
#rpc-certificate=/root/xxx.pem
# 在 RPC 服务中启用 SSL/TLS 加密时的私钥文件(.key)
#rpc-private-key=/root/xxx.key

## 文件保存相关 ##

# 文件的保存路径(可使用绝对路径或相对路径), 默认: 当前启动位置
dir=/root/Download
# 启用磁盘缓存, 0为禁用缓存, 需1.16以上版本, 默认:16M
#disk-cache=32M
# 文件预分配方式, 能有效降低磁盘碎片, 默认:prealloc
# 预分配所需时间: none < falloc ? trunc < prealloc
# falloc和trunc则需要文件系统和内核支持
# NTFS、EXT4 建议使用 falloc, EXT3 建议 trunc, MAC 下需要注释此项
file-allocation=${FILE_ALLOCATION:-falloc}
# 断点续传
continue=true
# 获取服务器文件时间，默认:false
remote-time=true

## 下载连接相关 ##

# 文件未找到重试次数，默认:0
# 重试时同时会记录重试次数，所以也需要设置 --max-tries 这个选项
max-file-not-found=5
# 最大尝试次数，0表示无限，默认:5
max-tries=0
# 重试等待时间（秒）, 默认:0
retry-wait=10
# 使用 UTF-8 处理 Content-Disposition ，默认:false
content-disposition-default-utf8=true
# 最大同时下载任务数, 运行时可修改, 默认:5
max-concurrent-downloads=5
# 同一服务器连接数, 添加时可指定, 默认:1
max-connection-per-server=16
# 最小文件分片大小, 添加时可指定, 取值范围1M -1024M, 默认:20M
# 假定size=10M, 文件为20MiB 则使用两个来源下载; 文件为15MiB 则使用一个来源下载
min-split-size=4M
# 单个任务最大线程数, 添加时可指定, 默认:5
split=16
# 整体下载速度限制, 运行时可修改, 默认:0
#max-overall-download-limit=0
# 单个任务下载速度限制, 默认:0
#max-download-limit=0
# 整体上传速度限制, 运行时可修改, 默认:0
max-overall-upload-limit=1M
# 单个任务上传速度限制, 默认:0
#max-upload-limit=1000
# 禁用IPv6, 默认:false
disable-ipv6=false
# 支持GZip，默认:false
http-accept-gzip=true
# URI复用，默认: true
reuse-uri=false
# 禁用 netrc 支持，默认:flase
no-netrc=true

## 进度保存相关 ##

# 从会话文件中读取下载任务
input-file=/root/.aria2/aria2.session
# 在Aria2退出时保存`错误/未完成`的下载任务到会话文件
save-session=/root/.aria2/aria2.session
# 定时保存会话, 0为退出时才保存, 需1.16.1以上版本, 默认:0
save-session-interval=1
# 自动保存任务进度，0为退出时才保存，默认：60
auto-save-interval=1
# 强制保存会话, 即使任务已经完成, 默认:false
# 较新的版本开启后会在任务完成后依然保留.aria2文件
#force-save=true

## BT/PT下载相关 ##

# 当下载的是一个种子(以.torrent结尾)时, 自动开始BT任务, 默认:true，可选：false|mem
#follow-torrent=true
# BT监听端口, 当端口被屏蔽时使用, 默认:6881-6999
listen-port=51413
# 单个种子最大连接数，0为不限制，默认:55
bt-max-peers=0
# DHT（IPv4）文件
dht-file-path=/root/.aria2/dht.dat
# DHT（IPv6）文件
dht-file-path6=/root/.aria2/dht6.dat
# 打开DHT功能, PT需要禁用, 默认:true
enable-dht=true
# 打开IPv6 DHT功能, PT需要禁用
enable-dht6=true
# DHT网络监听端口, 默认:6881-6999
dht-listen-port=6881-6999
# 本地节点查找, PT需要禁用, 默认:false
bt-enable-lpd=true
# 种子交换, PT需要禁用, 默认:true
enable-peer-exchange=true
# 期望下载速度，Aria2会临时提高连接数以提高下载速度，单位K或M。默认:50K
bt-request-peer-speed-limit=10M
# 客户端伪装, PT需要保持user-agent和peer-agent两个参数一致
user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3602.2 Safari/537.36
#user-agent=qBittorrent v4.1.3
peer-agent=qBittorrent v4.1.3
peer-id-prefix=-qB4130-
#peer-agent=uTorrentMac/1870(43796)
#peer-id-prefix=-UM1870-
#peer-agent=Deluge 1.3.15
#peer-id-prefix=-DE13F0-
#peer-agent=Transmission/2.92
#peer-id-prefix=-TR2920-
# 当种子的分享率达到这个数时, 自动停止做种, 0为一直做种, 默认:1.0
seed-ratio=1.0
# 最小做种时间（分钟）。此选项设置为0时，将在BT任务下载完成后不进行做种。
seed-time=0
# BT校验相关, 默认:true
#bt-hash-check-seed=true
# 继续之前的BT任务时, 无需再次校验, 默认:false
#bt-seed-unverified=true
# 保存磁力链接元数据为种子文件(.torrent文件), 默认:false
bt-save-metadata=true
# 加载已保存的元数据文件，默认:false
bt-load-saved-metadata=true
# 删除未选择文件，默认:false
bt-remove-unselected-file=true
# 保存上传的种子，默认:true
#rpc-save-upload-metadata=false

## 执行额外命令 ##

# 下载停止后执行的命令（下载停止包含下载错误和下载完成这两个状态，如果没有单独设置，则执行此项命令。）
# 删除文件及.aria2后缀名文件
on-download-stop=/root/.aria2/delete.sh
# 下载错误后执行的命令（下载停止包含下载错误这个状态，如果没被设置或被注释，则执行下载停止后执行的命令。）
#on-download-error=
# 下载完成后执行的命令（下载停止包含下载完成这个状态，如果没被设置或被注释，则执行下载停止后执行的命令。）
# 删除.aria2后缀名文件
on-download-complete=/root/.aria2/delete.aria2.sh
# 调用 rclone 上传(move)到网盘
#on-download-complete=/root/.aria2/autoupload.sh
# 下载暂停后执行的命令
# 显示下载任务信息
#on-download-pause=/root/.aria2/info.sh
# 下载开始后执行的命令
#on-download-start=

## BT服务器 ##
bt-tracker=

EOF

rclone config --config ${RCLONE_OPTS:-/config}/rclone.conf & aria2c --conf-path=/root/.aria2/aria2.conf