# Must Install

Here are some applications that you need to install in order to replicate this experiment:
1. Terraform
2. Azure-CLI
3. Ansible
4. Vagrant (optional)

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

# Prerequisites: Configure Inventory File

After you bootstrap the infra, you can setup your inventory file in `./ansible/inventories/<inventory-name>`. You can follow existing inventory file formats.

# Prerequisites: Wireguard Install

## Generate keypair for server and client

You can generate your own key instead of using the one in the inventory file.

```bash
wg genkey | tee server.privatekey | wg pubkey > server.publickey
wg genkey | tee worker.privatekey | wg pubkey > worker.publickey
wg genkey | tee edge.privatekey | wg pubkey > edge.publickey
```

## Install WireGuard
```bash
ansible-playbook -i ./ansible/inventories/<inventory-name> ./ansible/playbooks/wireguard.yml -v
```

# K3s Install

K3s version as of install: v1.26.4+k3s1

```bash
ansible-playbook -i ./ansible/inventories/<inventory-name> ./ansible/playbooks/k3s.yml -v
```

# Nomad Install

```bash
ansible-playbook -i ./ansible/inventories/<inventory-name> ./ansible/playbooks/nomad.yml -v
```

# KubeEdge Install

```bash
ansible-playbook -i ./ansible/inventories/<inventory-name> ./ansible/playbooks/kubeedge.yml -v
```