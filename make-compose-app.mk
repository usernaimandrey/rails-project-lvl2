app-bash:
	docker compose run --rm app bash

app-make:
	docker compose run --rm app $(T)

app-lint:
	docker compose run --rm app make lint

app-test:
	docker compose run --rm app make test

app-lint-fix:
	docker compose run --rm app make lint-fix

app-check:
	docker run --rm $(T) make ci-check
