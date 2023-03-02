# Multi-node Jenkins environment

This playbook will set up a multi node cluster in the specified machines. To start, you should create an ssh key for ansible

```
ssh-keygen -t ed25519 -C "ansible"
```

Copy the public key to your vm:

```
ssh-copy-id -i ~/.ssh/ansible.pub <your_vm_ip>
```

Add you vm to the vm list in the inventory file.

Open the bootstrap.yaml and add your public key for the jenkin user.

Run bootstrap.yaml with:

```
ansible-playbook --become-pass bootstrap.yaml
```

This wil create the necessary base configuration. Open the ansible.cfg file and add the line:

```
remote_user = jenkins
```

Install the rest of the system with:

```
ansible-playbook jenkins.yaml
```
