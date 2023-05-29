# Infra Setup

We initialize the infra using Terraform. Before creating the resource, do the following:

1. Create resource-group, storage-account, and storage-account container via your Azure dashboard
2. Update to `$PWD/terraform/<orchestrator>/provider.tf` accordingly
3. Apply!
4. Take a note of the master node IP from Terraform output

```bash
cd terraform
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
sudo apt-get update && sudo apt install wireguard -y
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
sudo apt clean
```

## Client x64

```bash
sudo apt-get update && sudo apt install wireguard -y
MASTER_VM_IP=20.222.87.252
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
sudo apt clean
```

## Client ARM

```bash
sudo apt-get update && sudo apt install wireguard -y
MASTER_VM_IP=20.89.20.50
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
sudo apt clean
```

# K3s Install

K3s version as of install: v1.26.4+k3s1

```bash
# Master
curl -sfL https://get.k3s.io | sh -s - \
    --write-kubeconfig-mode 644 \
    --disable servicelb \
    --disable traefik \
    --disable metrics-server \
    --disable local-storage \
    --node-external-ip 20.89.20.50 \
    --advertise-address 10.112.0.1 \
    --token "K1088326be4c13d64b9aa9a6439e4f30570432dd61981b533c347a082612a1bc49f::server:4b7e56a711ff12f36e10c0081fa4bf5a" \
    --flannel-iface wg0
sudo cat /var/lib/rancher/k3s/server/node-token

# Worker
curl -sfL https://get.k3s.io | \
    K3S_URL=https://10.112.0.1:6443 \
    K3S_TOKEN="K1088326be4c13d64b9aa9a6439e4f30570432dd61981b533c347a082612a1bc49f::server:4b7e56a711ff12f36e10c0081fa4bf5a" \
    sh -s - --flannel-iface wg0
```

# Nomad Install

Run these script first in all nodes to install Nomad.

```bash
sudo apt-get update && sudo apt-get install wget gpg coreutils containerd
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install nomad

curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v1.0.0.tgz && \
  sudo mkdir -p /opt/cni/bin && \
  sudo tar -C /opt/cni/bin -xzf cni-plugins.tgz

rm /home/nomad/cni-plugins.tgz

echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-arptables && \
  echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-ip6tables && \
  echo 1 | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables
```

## Server

```bash
sudo mkdir /opt/nomad/data/plugins
sudo wget https://github.com/Roblox/nomad-driver-containerd/releases/download/v0.9.3/containerd-driver -O /opt/nomad/data/plugins/containerd-driver
sudo chmod +x /opt/nomad/data/plugins/containerd-driver
cat << EOF | sudo tee /etc/nomad.d/nomad.hcl
data_dir  = "/opt/nomad/data"
bind_addr = "10.112.0.1"

plugin "containerd-driver" {
  config {
    enabled = true
    containerd_runtime = "io.containerd.runc.v2"
    stats_interval = "5s"
  }
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true
  servers = ["10.112.0.1"]
}
EOF
sudo systemctl enable nomad
sudo systemctl start nomad
```

## Client x64

```bash
sudo mkdir /opt/nomad/data/plugins
sudo wget https://github.com/Roblox/nomad-driver-containerd/releases/download/v0.9.3/containerd-driver -O /opt/nomad/data/plugins/containerd-driver
sudo chmod +x /opt/nomad/data/plugins/containerd-driver
cat << EOF | sudo tee /etc/nomad.d/nomad.hcl
data_dir  = "/opt/nomad/data"
bind_addr = "10.112.0.50"

plugin "containerd-driver" {
  config {
    enabled = true
    containerd_runtime = "io.containerd.runc.v2"
    stats_interval = "5s"
  }
}

client {
  enabled = true
  servers = ["10.112.0.1"]
}
EOF
sudo systemctl enable nomad
sudo systemctl start nomad
```

## Client ARM

```bash
sudo mkdir /opt/nomad/data/plugins
sudo wget https://cloudcomputingfiles.blob.core.windows.net/containerd-driver/containerd-driver -O /opt/nomad/data/plugins/containerd-driver
sudo chmod +x /opt/nomad/data/plugins/containerd-driver
cat << EOF | sudo tee /etc/nomad.d/nomad.hcl
data_dir  = "/opt/nomad/data"
bind_addr = "10.112.0.51"

plugin "containerd-driver" {
  config {
    enabled = true
    containerd_runtime = "io.containerd.runc.v2"
    stats_interval = "5s"
  }
}

client {
  enabled = true
  servers = ["10.112.0.1"]
}
EOF
sudo systemctl enable nomad
sudo systemctl start nomad
```

# KubeEdge Install

```bash
# Master
curl -sfL https://get.k3s.io | sh -s - \
    --write-kubeconfig-mode 644 \
    --docker \
    --disable servicelb \
    --disable traefik \
    --disable metrics-server \
    --disable local-storage \
    --node-external-ip 52.253.116.190 \
    --advertise-address 10.112.0.1 \
    --token "K1088326be4c13d64b9aa9a6439e4f30570432dd61981b533c347a082612a1bc49f::server:4b7e56a711ff12f36e10c0081fa4bf5a" \
    --flannel-iface wg0
sudo cat /var/lib/rancher/k3s/server/node-token

# Worker
curl -sfL https://get.k3s.io | \
    K3S_URL=https://10.112.0.1:6443 \
    K3S_TOKEN="K1088326be4c13d64b9aa9a6439e4f30570432dd61981b533c347a082612a1bc49f::server:4b7e56a711ff12f36e10c0081fa4bf5a" \
    sh -s - --flannel-iface wg0
```