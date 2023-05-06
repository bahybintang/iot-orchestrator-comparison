# Infra Setup
We initialize the infra using terraform. Before creating the resource, do the following: 
1. Create resource-group, storage-account, and storage-account container via your Azure dashboard
2. Update to `$PWD/terraform/<orchestrator>/provider.tf` accordingly
3. Apply!


```bash
$ORCHESTRATOR=k3s # Possible value k3s, nomad, kubeedge
cd terraform/$ORCHESTRATOR
terraform apply
```

# Prerequisites: Wireguard Install

Generate keypair for server and client.
```bash
wg genkey | tee server.privatekey | wg pubkey > server.publickey
wg genkey | tee client.privatekey | wg pubkey > client.publickey

# server.privatekey cI51/+JENUzUztNHoDZyYvCiZ833BM2Z3C7WRvAPbFg=
# server.publickey sJsaywr1e4lup7+WLA0ZK5NJmYzzqSnCtrQqSvv0QHM=
# client.privatekey mIEQJ/8oSoxtt0uaJYsdr+g7XlIw5xIF/cFL3qtlxns=
# client.publickey zrtvEkLj/cxhKZ32Yg2YqCg2IYdsukIu7c5/P71X01I=
# client1.privatekey oBABPseRkCIN3lGAW+xq/qnHmp9cEfx+Th1Y7SMmU14=
# client1.publickey Z2uGbn1AaprbyUa1SjbPw9GYEuWDZifQmtk13AF60XI=
```

## Server
```bash
sudo apt-get update && sudo apt install wireguard
sudo sysctl -w net.ipv4.ip_forward=1
cat << 'EOF' | sudo tee /etc/wireguard/wg0.conf
# /etc/wireguard/wg0.conf
[Interface]

# The IP address of this host in the wireguard tunnels
Address = 10.112.0.1
PostUp = /etc/wireguard/add-nat.sh
PostDown = /etc/wireguard/del-nat.sh

# Every client connects via UDP to this port. Your Cloud VM must be reachable on this port via UDP from the internet.
ListenPort = 51871
Table = off

# Set the private key to the value of server
PrivateKey = cI51/+JENUzUztNHoDZyYvCiZ833BM2Z3C7WRvAPbFg=

# Set the MTU according to the internet connections of your clients
# In our case the autodetection assumed 8920 since the cloud network supported jumbo frames.
MTU = 1420

[Peer]
# Client's public key and IP
PublicKey = Z2uGbn1AaprbyUa1SjbPw9GYEuWDZifQmtk13AF60XI=
AllowedIPs = 10.112.0.51/32

[Peer]
# Client's public key and IP
PublicKey = zrtvEkLj/cxhKZ32Yg2YqCg2IYdsukIu7c5/P71X01I=
AllowedIPs = 10.112.0.50/32
EOF
cat  << 'EOF' | sudo tee /etc/wireguard/add-nat.sh
#!/bin/bash
IPT="/usr/sbin/iptables"

IN_FACE="eth0"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC
SUB_NET="10.112.0.0/24"            # WG IPv4 sub/net aka CIDR
WG_PORT="51871"                  # WG udp port

## IPv4 ##
$IPT -t nat -I POSTROUTING 1 -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -I INPUT 1 -i $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -I INPUT 1 -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT
EOF
cat  << 'EOF' | sudo tee /etc/wireguard/del-nat.sh
#!/bin/bash
IPT="/usr/sbin/iptables"

IN_FACE="eth0"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC
SUB_NET="10.112.0.0/24"            # WG IPv4 sub/net aka CIDR
WG_PORT="51871"                  # WG udp port

## IPv4 ##
$IPT -t nat -D POSTROUTING -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -D INPUT -i $WG_FACE -j ACCEPT
$IPT -D FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -D FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -D INPUT -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT
EOF
sudo chmod +x /etc/wireguard/add-nat.sh
sudo chmod +x /etc/wireguard/del-nat.sh
sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
sudo ip route add 10.112.0.0/24 dev wg0 scope link
```

## Client x64
```bash
sudo apt-get update && sudo apt install wireguard
MASTER_VM_IP=20.89.91.210
CLIENT_WG_IP=10.112.0.50 # Worker x64
cat << EOF | sudo tee /etc/wireguard/wg0.conf
# /etc/wireguard/wg0.conf
[Interface]
# The IP address of the client in the wireguard network
Address = $CLIENT_WG_IP/32

# Private key of the client
PrivateKey = mIEQJ/8oSoxtt0uaJYsdr+g7XlIw5xIF/cFL3qtlxns=

[Peer]
# Public Key of the cloud VM
PublicKey = sJsaywr1e4lup7+WLA0ZK5NJmYzzqSnCtrQqSvv0QHM=

# Public IP of the cloud VM
Endpoint = $MASTER_VM_IP:51871

# All traffic for the wireguard network should be routed to our cloud VM
AllowedIPs = 10.112.0.0/24

# Since our clients are located behind NAT devices, send keep alives to our cloud VM to keep the connection in the NAT tables.
PersistentKeepalive = 20
EOF
sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
```

## Client ARM
```bash
sudo apt-get update && sudo apt install wireguard
MASTER_VM_IP=20.89.91.210
CLIENT_WG_IP=10.112.0.51 # Worker ARM
cat << EOF | sudo tee /etc/wireguard/wg0.conf
# /etc/wireguard/wg0.conf
[Interface]
# The IP address of the client in the wireguard network
Address = $CLIENT_WG_IP/32

# Private key of the client
PrivateKey = oBABPseRkCIN3lGAW+xq/qnHmp9cEfx+Th1Y7SMmU14=

[Peer]
# Public Key of the cloud VM
PublicKey = sJsaywr1e4lup7+WLA0ZK5NJmYzzqSnCtrQqSvv0QHM=

# Public IP of the cloud VM
Endpoint = $MASTER_VM_IP:51871

# All traffic for the wireguard network should be routed to our cloud VM
AllowedIPs = 10.112.0.0/24

# Since our clients are located behind NAT devices, send keep alives to our cloud VM to keep the connection in the NAT tables.
PersistentKeepalive = 20
EOF
sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
```

# K3s Install
```bash
# Master
curl -sfL https://get.k3s.io | sh -s - \
    --write-kubeconfig-mode 644 \
    --disable servicelb \
    --disable traefik \
    --disable metrics-server \
    --disable local-storage \
    --node-external-ip 20.89.91.210 \
    --advertise-address 10.112.0.1 \
    --flannel-iface wg0
sudo cat /var/lib/rancher/k3s/server/node-token

# Worker
curl -sfL https://get.k3s.io | \
    K3S_URL=https://10.112.0.1:6443 \
    K3S_TOKEN="K1063827ba8fa58b8c99bb8252adab8919fe358c5c9e1791664228949f26d197941::server:a5ba68d46acc0cba3538cd4310ff2e65" \
    sh -s - --flannel-iface wg0
```
