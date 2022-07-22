setup:
	bin/setup
	bin/rails db:seed

start:
	bin/rails s -p 3000 -b "0.0.0.0"

console:
	bin/rails console

push:
	./git.sh $(commit) $(opt)

deploy:
	git push heroku main

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

test:
	NODE_ENV=test bin/rails test

.PHONY: test
