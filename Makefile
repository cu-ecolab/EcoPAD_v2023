cyberpath := CyberCommons

$(cyberpath)/dc_config/secrets.env:
# Creating secrets file for editing
ifndef EDITOR
ifeq ($(strip $(shell which nano)),)
$(error dc_config/secrets.env will need to be manually created. Copy dc_config/secrets_template.env as a starting point)
endif
endif
	@cp $(cyberpath)/dc_config/secrets_template.env $(cyberpath)/dc_config/secrets.env
	@$${EDITOR:-nano} $(cyberpath)/dc_config/secrets.env


include $(cyberpath)/dc_config/cybercom_config.env
include $(cyberpath)/dc_config/secrets.env

# Set GITPOD_PORT to 8080 if run in gitpod
ifneq ($(strip $(GITPOD_WORKSPACE_ID)),)
	GITPOD_PORT = 8080
	ALLOWED_HOSTS = .gitpod.io,localhost
endif

ifeq ($(strip $(shell docker compose 1>/dev/null && echo 0)),0)
	COMPOSE := docker compose
else
	COMPOSE := docker-compose
endif

COMPOSE_INIT = $(COMPOSE) -f $(cyberpath)/dc_config/images/docker-compose-init.yml
CERTBOT_INIT = $(COMPOSE) -f $(cyberpath)/dc_config/images/certbot-initialization.yml
DJANGO_MANAGE = $(COMPOSE) run --rm $(cyberpath)/cybercom_api ./$(cyberpath)/manage.py

SHELL = /bin/bash

.PHONY: cybercommon-init cybercommon-build cybercommon-run cybercommon-stop

cybercommon-init:
	$(MAKE) -C CyberCommons init

cybercommon-build:
	$(MAKE) -C CyberCommons build

cybercommon-run:
	$(MAKE) -C CyberCommons run

cybercommon-stop:
	$(MAKE) -C CyberCommons stop

init:
	$(COMPOSE_INIT) build
	$(COMPOSE_INIT) up
	$(COMPOSE_INIT) down

run:
	$(COMPOSE_INIT) build
	$(COMPOSE_INIT) up
	$(COMPOSE_INIT) down
	@$(COMPOSE) --compatibility build
	@$(COMPOSE) --compatibility up -d

stop:
	@$(COMPOSE) --compatibility down