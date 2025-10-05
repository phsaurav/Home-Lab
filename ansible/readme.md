## Directory layout

```txt
.ansible/
├── ansible.cfg                         # Ansible common config
├── secrets.yaml                        # Ansible Vault Secret
├── inventories/                        # All inventory directory
│   └── dev/                            # Dev Environement
│       ├── hosts.yml                   # Holds all Dev Hosts Data
│       └── group_vars/                 # Group Variables
│           ├── all.yml
│           ├── k8s_control_plane.yml
│           └── k8s_workers.yml
├── playbooks/
│   ├── site.yml                # Initial Setup for all hosts
│   ├── cluster_init.yml        # Applied to control-plane only
│   ├── join_workers.yml        # Applied to workers only
│   └── support_tools.yml       # Optional extras
└── roles/
    ├── base_setup/
    ├── containerd/
    ├── kube_packages/
    ├── control_plane/
    ├── node_join/
    └── support_tools/
```

This Ansible implementation automates Kubernetes setup of Ubuntu Cluster in Development Environment.

## Requirements

- Ansible ≥ 2.10 (collections not strictly required; add as needed).
- SSH access to each Ubuntu host via the user defined in `ansible.cfg`.
- `sudo` privileges on all nodes.

## Secrets management

Structure:
```txt
host_ips:
  master-01: 
  worker-01: 
  worker-02: 

proxmox_vm_ids:
  master-01: 
  worker-01: 
  worker-02: 

user_name: 
control_plane_endpoint: 
```

All sensitive information lives in ansible/secret.yaml, encrypted with Ansible Vault.

1. Create or edit the secrets file
```bash
cd ansible
ansible-vault create secret.yaml   # or `ansible-vault edit secret.yaml`
```

3. Vault password
 • Prompt each run with `--ask-vault-pass`

4. Editing later
```bash
ansible-vault edit secret.yaml
ansible-vault view secret.yaml
```

## Usage

From the `.ansible` directory:

1. **Bootstrap everything (common prep, control plane, and worker join):**
```bash
ansible-playbook playbooks/site.yaml -e @secret.yaml --ask-vault-pass
```
2. **Re-run control-plane initialization only (after a reset or rebuild):**
```bash
ansible-playbook playbooks/cluster_init.yaml -e @secret.yaml --ask-vault-pass
```
3. **Join workers (e.g., after adding new nodes):**
```bash
ansible-playbook playbooks/join_workers.yaml -e @secret.yaml --ask-vault-pass
 ```
4. Optional helper tooling (kubectl aliases, etc.):
Set `support_tools_enabled: true` in group_vars/all.yml.
Run:
```bash
ansible-playbook playbooks/support_tools.yaml -e @secret.yaml --ask-vault-pass
```

