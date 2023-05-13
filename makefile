# Variables
DOCKER_COMPOSE = docker compose
DOCKER_RUN = $(DOCKER_COMPOSE) run --rm backend

# Commandes
start:
	$(DOCKER_COMPOSE) up -d

stop:
	$(DOCKER_COMPOSE) down

restart:
	$(DOCKER_COMPOSE) down
	$(DOCKER_COMPOSE) up -d

rails:
	$(DOCKER_RUN) bin/rails $(filter-out $@,$(MAKECMDGOALS))

console:
	$(DOCKER_RUN) bin/rails console

db:
	$(DOCKER_RUN) bin/rails db:$(filter-out $@,$(MAKECMDGOALS))

migrate:
	$(DOCKER_RUN) bin/rails db:migrate

seed:
	$(DOCKER_RUN) bin/rails db:seed

test:
	$(DOCKER_RUN) bin/rails test $(filter-out $@,$(MAKECMDGOALS))

# Empêcher la création de cibles pour les commandes ci-dessus
.PHONY: start stop restart rails console db migrate seed test
