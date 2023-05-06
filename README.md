# K3s Install
```bash
# Master
curl -sfL https://get.k3s.io | sh -s - --node-external-ip="<MASTER_NODE_IP>" --tls-san="<MASTER_NODE_IP>" --flannel-backend=wireguard-native --flannel-external-ip
sudo cat /var/lib/rancher/k3s/server/node-token

# Worker x64
curl -sfL https://get.k3s.io | K3S_URL=https://10.0.2.4:6443 K3S_TOKEN=<TOKEN> sh

# Worker ARM
curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_NODE_IP>:6443 K3S_TOKEN=<TOKEN> sh
```
