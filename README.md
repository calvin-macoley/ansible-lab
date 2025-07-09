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
docker build --tag ansible-lab:latest .

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

When ansible.cfg and inventory.ini are created. Test it via this command:
```
ansible all -m ping
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

### Task 2:  Utilities playbook creation
To execute and install all utilities make sure that you are in the project folder and use:

```
ansible-playbook playbooks/system-prep.yml
```

### Task 3:  Web servers playbook installation
Now we need to install our Apache server by using the next command:
```
ansible-playbook playbooks/webserver.yml
```

### Task 4:  App playbook deployment ***(TODO)***
Here we need to create this folder structure:

```
/var/www/myapp/
├── html/
├── logs/
└── config/
```

To do so, execute the following command:
```
ansible-playbook playbooks/deploy-app.yml
```