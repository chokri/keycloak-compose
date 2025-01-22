# Keycloak Docker Compose Setup

This repository provides a simple way to run Keycloak with a PostgreSQL database using Docker Compose.

## Prerequisites

Make sure you have the following installed on your server:
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Getting Started

1. **Clone this repository** to your server:
   ```bash
   git clone https://github.com/chokri/keycloak-compose.git
   cd keycloak-compose
   ```

2. **Start the services**:
   ```bash
   make start
   ```

3. **Access Keycloak**:
   - Open your browser and go to yout dns (localhost:8080): [https://auth.example.com](https://auth.example.com).
   - Default admin credentials:
     - Username: `admin`
     - Password: `change-me`

4. **Stop the services**:
   ```bash
   make stop
   ```

## Environment Details

- **Keycloak Version**: `26.0`
- **Database**: PostgreSQL `15`

## Notes

- The `KC_DB_PASSWORD`, `KEYCLOAK_ADMIN_PASSWORD`, and other sensitive values should be updated for production use.
- The current setup uses self-signed certificates for HTTPS. Replace them with valid certificates for production.

Feel free to customize the setup as needed.
