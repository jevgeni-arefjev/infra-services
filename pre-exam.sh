#!/bin/bash -ex
# This script is used to test the Ansible playbook before the exam.
# It runs the playbook three times to check for idempotency after a reboot.
# The output is saved to pre_exam.txt for review.

date > pre_exam.txt

exec > >(tee -ia pre_exam.txt) 2>&1

hostname

# test if all infra is setup with one command
ansible-playbook infra.yaml --diff

# test if idempotent (no diff)
ansible-playbook infra.yaml --diff

ansible all -b -m reboot -a "test_command=uptime"

sleep 15

# test if still idempotent after reboot
ansible-playbook infra.yaml --diff

date