setup:
	ansible-playbook setup.yml -i inventory.ini -u andrey

deploy:
	ansible-playbook deploy.yml -i inventory.ini -vv --extra-vars "version=v5" -u andrey
