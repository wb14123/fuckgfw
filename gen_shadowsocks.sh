#!/bin/sh

# clone bestroutetb for generate iptable file
git clone https://github.com/ashi009/bestroutetb.git

# generate iptable file for shadowsocks
vps_host="192.81.135.252"
shadowsocks_port=8089

header="#!/bin/sh
iptables -t nat -N SHADOWSOCKS
# 自己的vps不应用转发规则
iptables -t nat -A SHADOWSOCKS -d $vps_host -j RETURN
# Ignore LANs IP address
iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN
# 国内的ip不应用转发规则"

footer="
# 其余的ip转发到shadowsocks
iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports $shadowsocks_port
iptables -t nat -A PREROUTING -p tcp -j SHADOWSOCKS
"

cd bestroutetb
./generate.sh fuck_gfw_1.sh \
	--profile=custom \
	--header="$header" \
	--footer="$footer" \
	--nodefaultgw=1 \
	--format="iptables -t nat -A SHADOWSOCKS -d %prefix/%length -j %gw" \
	--groupgw=1 \
	--netgw="RETURN" \
	--vpngw="NO_OUTPUT"

cat fuck_gfw_1.sh | grep -v "NO_OUTPUT" > fuck_gfw.sh
rm fuck_gfw_1.sh
cd ..
mv ./bestroutetb/fuck_gfw.sh ./
chmod +x fuck_gfw.sh
