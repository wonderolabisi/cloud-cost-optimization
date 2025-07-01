#!/bin/bash

echo "Running Terraform cloud cost optimization setup..."
terraform apply -auto-approve terraform/

echo "Running Ansible playbook for cloud cost optimization configuration..."
ansible-playbook ansible/playbook.yml
