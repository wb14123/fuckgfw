
This is just a reminder for me. So may not have so many details.

## Dependency:

* `opkg install iptables-mod-nat-extra`
* Shadowsocks (`libpolarssl` is its dependency, install it from trunk and make symbol links).
* dnsmasq (it should be installed by default)

## Steps:

Rules: Generate on your machine, move to your OpenWRT.

* Generate `fuck_gfw.sh` by `gen_shadowsocks.sh`, and move it to `/usr/bin`. `chmod +x` if necessary.
* Move `fuckgfw_dns.conf` to `/etc/fuckgfw_dns/`, and add `conf-dir=/etc/dnsmasq.d` to `/etc/dnsmasq.conf`.
* Cofing `/etc/shadowsocks.json`, the port should be the same defined in `gen_shadowsocks.sh`.
* Move the `fuck_gfw` to `/etc/init.d`, `chmod +x` if necessary.
* Start and enjoy it!
