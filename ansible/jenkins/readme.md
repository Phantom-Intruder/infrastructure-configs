# Multi-node Jenkins environment

This playbook will set up a multi node cluster in the specified machines. To start, you should create an ssh key for ansible

```
ssh-keygen -t ed25519 -C "ansible"
```

Copy the public key to your vm:

```
ssh-copy-id -i ~/.ssh/ansible.pub <your_vm_ip>
```

Add you vm to the vm list in the inventory file. There are two sections in the inventory file: master and slave. Any VM specified under master will have Jenkins installed in it, SSH keys generated, and the ssh public key distributed to all slave VMs. Any VMs specified under slave will have maven and sqlplus installed on them.

Rename the files in the host_vars folder with the names of your vms.

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

Now the foundation for setting up the master-slave system is complete, and you should be able to go to <JENKINS_MASTER_IP>:8080 and access the Jenkins system. To add the slaves in to the vm, check on Manage Jenkins > Manage nodes > New Node, and fill out the details. For authentication, you could choose to copy the private key of the master into the credentials section of Jenkins and select that credential from the drop down. Generation of the private key is handled by Ansible so that step can be skipped.
