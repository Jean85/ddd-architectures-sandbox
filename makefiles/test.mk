test:
	@docker-compose exec php vendor/bin/phpunit

test-coverage:
	@docker-compose exec php vendor/bin/phpunit --coverage-html coverage/
