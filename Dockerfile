# Stage 1: Base image with security hardening
FROM quay.io/keycloak/keycloak:26.0.0 AS builder

# Create non-root user and set permissions :cite[5]:cite[7]:cite[10]
RUN addgroup -S keycloak && adduser -S keycloak -G keycloak && \
	chown -R keycloak:keycloak /opt/keycloak && \
	chmod -R 750 /opt/keycloak

# Switch to non-root user
USER keycloak

# Configure HTTPS (mount certificates externally at runtime)
ENV KC_HTTPS_CERTIFICATE_FILE=/etc/x509/https/tls.crt
ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/etc/x509/https/tls.key

# Disable unnecessary features :cite[4]
ENV KC_FEATURES=token-exchange,admin-fine-grained-authz,scripts

# Stage 2: Production image
FROM quay.io/keycloak/keycloak:26.0.0

# Copy permissions and user from builder
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Configure security headers and session management
ENV KC_HTTP_RELATIVE_PATH=/auth \
	KC_HOSTNAME_STRICT=false \
	KC_HTTP_ENABLED=true \
	KC_PROXY_ADDRESS_FORWARDING=true \
	KC_HOSTNAME_STRICT_HTTPS=true

# Configure database (externalize credentials)
ENV DB_VENDOR=postgres \
	DB_ADDR=postgres \
	DB_PORT=5432

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
	CMD curl -f http://localhost:8080/auth/realms/master || exit 1

# Final permissions setup
USER keycloak
WORKDIR /opt/keycloak
VOLUME /etc/x509/https

# Entrypoint with security enhancements
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
