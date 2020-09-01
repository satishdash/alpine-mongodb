# Makefile to setup and teardown the container

setup:
	@echo "Setting up resources..."
	@docker-compose -f ./docker-compose.yml up -d --build --force-recreate
	@sleep 2
	@docker exec mongodb mongo admin enableAuthWithAdmin.js
	@docker exec mongodb mongo admin --authenticationDatabase "admin" -u "admin" -p "admin" createTestUser.js

teardown:
	@echo "Tearing down resources.."
	@docker-compose -f ./docker-compose.yml rm -f -v -s
	@docker system prune -f
