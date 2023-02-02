setup:
	cp -n .env.example .env || true
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

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop -A

test:
	bin/rails db:environment:set RAILS_ENV=test
	bin/rails test

check:
	make test
	make lint

setup-ci:
	make setup
	yarn install
	RAILS_ENV=test bin/rails assets:precompile

.PHONY: test
