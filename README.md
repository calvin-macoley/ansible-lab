# Ansible lab

## Scenario
My company needs to deploy a simple web application accross multiple servers.

## Lab setup
### Docker containers
Before launching Dockers under, add your root password in the Dockerfile at line 9 **"root:<your_password>"**.

In a CLI launch those commands to setup the lab:

```
# Make sure that you are in the lab folder
pwd

# Create the image based on the Dockerfile
docker build --tag ansible-lab:latest -f Dockerfile .

# Create the two containers
docker run -d --name web1 -p 8081:80 -p 2221:22 ansible-lab:latest
docker run -d --name web2 -p 8082:80 -p 2222:22 ansible-lab:latest

# Insure that our two containers are created
docker ps
```

## Task setup

### Task 1:  create folders architecture
```
ansible-lab/
├── inventory.ini
├── ansible.cfg
├── playbooks/
│   ├── site.yml
│   └── webserver.yml
├── group_vars/
│   └── all.yml
├── host_vars/
├── files/
└── templates/
```

Here I encrypted my inventory.ini file so, I'll invite you to create your own inventory if you want to use this project (do not forget to change the ansible.cfg at line 3). Here is an example:

```
[webservers]
web1 ansible_host=<change_host> ansible_port=<change_port>
web2 ansible_host=<change_host>  ansible_port=<change_port>

# Conf in case you want to use an ubuntu EC2 instance
web3 ansible_host=<change_host>  ansible_ssh_private_key_file=.<put_you_pem_path_here> ansible_user=ubuntu

[databases]
[webservers:vars]
ansible_connection=ssh
ansible_user=root
ansible_password=<your_password>
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

When ansible.cfg and inventory.ini are created. Test it via this command:
```
ansible all -m ping
```
*<ins>NB.</ins>: if you are running this command on MacOS be sure to install sshpass before ([link to Homebrew](https://brew.sh/)).*
```
brew install hudochenkov/sshpass/sshpass
```

The result:
```
[WARNING]: Platform linux on host web2 is using the discovered Python interpreter at /usr/bin/python3.12, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
web2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.12, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
web1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}
```

### Task 2: Encrypt your inventory file

Now let's secure your own inventory file:

```
ansible-vault encrypt <your_file_name>
```

### Task 3: Deployment
Now that everything is set up and tested, we can deploy our environments by runnning the following command:

```
ansible-playbook playbooks/site.yml --ask-vault-pass

OR

ansible-playbook playbooks/site.yml --vault-password-file <your_path_to_file> #if password stored in a file
```
*<ins>NB.</ins>: use the --check option to lauch a Dry Run of the playbook*

If everything is correctly you should see no failures in the play recap:

![alt text](screenshots/play_recap.png)

Next, navigate to the following URLs:
```
http://localhost:8081/
http://localhost:8082/
```

Here are the screens of you deployed websites:
<div style="display: flex; gap: 10px;">
  <img src="screenshots/web1.png" alt="Website 1" style="width: 49%;">
  <img src="screenshots/web2.png" alt="Website 2" style="width: 49%;">
</div>

### Memento

Roles are a way to organize and package related tasks, variables, files, templates and handlers into a reusable structured format. Roles promote code reusability and make playbooks cleaner by grouping related automation logic together.

To create a role:

```
ansible-galaxy init <name>
```