setup:
	ansible-playbook setup.yml -i inventory.ini --vault-password-file files/vault_pass -u $$USER

deploy:
	ansible-playbook deploy.yml -i inventory.ini --vault-password-file files/vault_pass -vv --extra-vars "version=v8" -u $$USER
