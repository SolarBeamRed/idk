#!/bin/bash

set -e

sudo apt update

sudo apt install -y ansible

mkdir -p ~/devops/program7

cd ~/devops/program7

###############################################################################
# INVENTORY
###############################################################################

cat > hosts.ini << 'EOF'
[local]
localhost ansible_connection=local
EOF

###############################################################################
# PLAYBOOK
###############################################################################

cat > setup.yml << 'EOF'
---
- name: Basic Server Setup
  hosts: local

  tasks:

    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install curl
      apt:
        name: curl
        state: present
EOF

###############################################################################
# EXECUTE PLAYBOOK
###############################################################################

sudo ansible-playbook -i hosts.ini setup.yml
