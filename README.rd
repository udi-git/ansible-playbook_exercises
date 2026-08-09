# Ansible Deployment Project

This repository contains Ansible playbooks to automate the deployment and configuration of remote servers. The project covers four separate administration tasks supporting a mixed environment of Ubuntu (Debian) and CentOS (RedHat) hosts.

## Project Structure & Architecture
- **`inventory`**: Defines the managed hosts (`server1` - Ubuntu, `server2` - CentOS).
- **`host_vars/` & `group_vars/`**: Contains host-specific and group-specific connection variables and configurations.
- **`ngnix_setup.yml`**: Playbook for Nginx installation and web page deployment.
- **`deploy_flask.yml`**: Playbook for setting up the Python Flask web application.
- **`managing_users.yml`**: Playbook for system user lifecycle management.
- **`prometheus_node.yml`**: Playbook for Prometheus Node Exporter package installation.

---

## Prerequisites
- Ansible installed on the control node.
- Valid SSH connection and privilege escalation (`sudo`) configured for all target nodes.

---

## Task Details & Execution Instructions

### 1. Nginx Deployment (`ngnix_setup.yml`)
Automates the installation and execution of the Nginx web server and deploys a custom landing page.
- Updates package manager caches and installs Nginx.
- Ensures the `nginx` service is enabled and running.
- Deploys a custom `index.html` file to the default web root directory.

**Execution:**
```bash
ansible-playbook -i inventory ngnix_setup.yml


### 2. Flask Application Deployment (deploy_flask.yml)
Sets up a Python 3 environment and deploys a basic Flask web application.

Installs Python 3 and pip package manager.

Installs Flask via pip (handling OS-specific PEP 668 constraints using --break-system-packages where required).

Creates the application script (app.py).

Launches the Flask app in the background on port 5000 using nohup.

Execution:
ansible-playbook -i inventory deploy_flask.yml

### 3. User Management (managing_users.yml)
Handles user account lifecycle management across managed servers.

Creates a new user account (new_user) with defined parameters.

Removes an obsolete user account (old_user) along with their home directory (remove: yes).

Execution:

Bash
ansible-playbook -i inventory managing_users.yml

### 4. Prometheus Node Exporter (prometheus_node.yml)
Automates package repository updates and installs Prometheus Node Exporter.

Executes apt update (using update_cache: true).

Installs the prometheus-node-exporter package.

Utilizes task conditionals (when: ansible_facts['os_family'] == "Debian") to target Ubuntu systems while gracefully skipping RedHat/CentOS hosts.

Execution:

Bash
ansible-playbook -i inventory prometheus_node.yml
