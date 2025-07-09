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
web1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.11"
    },
    "changed": false,
    "ping": "pong"
}
```

### Task 2:  Utilities playbook creation
### Task 2:  Web servers playbook installation
### Task 2:  App playbook deployment
