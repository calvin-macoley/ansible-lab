pipeline {
    agent any

    // Store the password in Jenkins under Manage jenkins -> Credentials
    environment {
        ANSIBLE_VAULT_PASSWORD_FILE = credentials('ansible-vault')
    }

    stages {
        stage('Connection test') {
            steps {
                echo "Testing playbook"
                withCredentials([
                    file(credentialsId: 'AWS_PEM', variable: 'AWS_PEM')
                ]) {
                    script {
                    sh '''
                    echo  '${ANSIBLE_VAULT_PASSWORD_FILE}' > vault_pass.txt
                    chmod 600 vault_pass.txt
                    mkdir -p secrets
                    cp ${AWS_PEM} secrets/
                    ls -ll secrets/
                    chmod 600 secrets/*
                    ansible webservers-us-east-1 -i inventory.ini -m ping --vault-password-file vault_pass.txt
                    '''
                    }
                }                
            }
        }

        stage('Playbook test') {
            steps {
                echo "Testing playbook"
                withCredentials([
                    file(credentialsId: 'AWS_PEM', variable: 'AWS_PEM')
                ]) {
                    script {
                    sh '''
                    echo  '${ANSIBLE_VAULT_PASSWORD_FILE}' > vault_pass.txt
                    chmod 600 vault_pass.txt
                    mkdir -p secrets
                    cp ${AWS_PEM} secrets/
                    chmod 600 secrets/*
                    ansible-playbook -i inventory.ini playbooks/site.yml --vault-password-file vault_pass.txt --syntax-check
                    '''
                    }
                }                
            }
        }

        stage('Deploy') {
            steps {
                echo "Testing playbook"
                withCredentials([
                    file(credentialsId: 'AWS_PEM', variable: 'AWS_PEM')
                ]) {
                    script {
                    sh '''
                    echo  '${ANSIBLE_VAULT_PASSWORD_FILE}' > vault_pass.txt
                    chmod 600 vault_pass.txt
                    mkdir -p secrets
                    cp ${AWS_PEM} secrets/
                    chmod 600 secrets/*
                    ansible-playbook -i inventory.ini playbooks/site.yml --vault-password-file vault_pass.txt
                    '''
                    }
                }                
            }
        }
    }
}