static-check: code-style-fix phpstan psalm

code-style-fix:
	@echo "CODE STYLE FIX"
	@echo ""
	@docker-compose exec -T php vendor/bin/php-cs-fixer fix --ansi --verbose

phpstan:
	@echo "PHP STAN"
	@echo ""
	@docker-compose exec -T php ./vendor/bin/phpstan analyse --ansi --configuration=phpstan.neon

psalm:
	@echo "PSALM"
	@echo ""
	@docker-compose exec -T php ./vendor/bin/psalm --show-info=true
	@echo ""
