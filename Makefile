include make-compose.mk
include make-compose-app.mk

setup:
	make prepare-env	
	bin/setup
	# bin/rails db:seed
	make db-reset

prepare-env:
	cp -n .env.example .env || true

fixtures-load:
	bin/rails db:fixtures:load

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:schema:load
	bin/rails db:migrate
	bin/rails db:fixtures:load

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

setup-ci:
	make setup
	yarn install
	RAILS_ENV=test bin/rails assets:precompile

ci-check:
	make lint
	bin/rails db:create
	make test


start-production:
	bin/rails db:migrate
	bin/rails server -e production

.PHONY: test
