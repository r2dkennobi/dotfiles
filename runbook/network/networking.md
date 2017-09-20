# Check and enable promiscuous
`$ netstat -i`
Fig contains 'P' if enabled
To enable: `ifconfig <dev> promisc` or `ip link set <dev> promisc on`

# Capture full packets
-nn: no hostname nor port resolution
`sudo tcpdump -i <dev> -nn -s0 -w <blah>.pcap`

# traceroute + ping
`mtr`

# References
- [tcpdump](https://danielmiessler.com/study/tcpdump/#gs.W__=3cc)
