# Start Keycloak and PostgreSQL
start:
	docker compose up -d

# Stop Keycloak and PostgreSQL
stop:
	docker compose down

# Restart Keycloak and PostgreSQL
restart:
	docker compose down && docker-compose up -d

# View logs for Keycloak
logs:
	docker compose logs -f keycloak
