setup:
	ansible-playbook setup.yml -i inventory.ini -u andrey

deploy:
	ansible-playbook deploy.yml -i inventory.ini --vault-password-file files/vault_pass -vv --extra-vars "version=v6" -u andrey
