start:
	docker-compose up -d

shell: start
	@docker-compose exec php zsh

setup: start composer-install

stop: legacy-stop
	@docker-compose stop

composer-install: start
	@docker-compose exec -T php composer install --ansi

xdebug-ip:
	$(eval ADDRESS=$(shell docker-compose exec php ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | sed -e 's/via //' || echo "NOT RECOGNIZED"))
	$(eval SED_SUBSTITUTION:="s/(remote_host=)([0-9]{1,3}.){3}[0-9]{1,3}/\\1$(ADDRESS)/")
	sed -ri $(SED_SUBSTITUTION) docker-compose.override.yml
	echo Changed ip address for debug into $(ADDRESS), please check your docker-compose.override.yml
	echo ""
	@make start
