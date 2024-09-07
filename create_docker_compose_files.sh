#!/bin/bash

# Create docker-compose.core.yml
cat > docker-compose.core.yml <<EOL
version: "3.8"
services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: fraud_detection
    networks:
      - app-network

  kafka:
    image: wurstmeister/kafka:latest
    depends_on:
      - zookeeper
    networks:
      - app-network

  zookeeper:
    image: wurstmeister/zookeeper:latest
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
EOL

# Create docker-compose.fraud.yml
cat > docker-compose.fraud.yml <<EOL
version: "3.8"
services:
  fraud-detection-service:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - .:/app
    depends_on:
      - postgres
    networks:
      - app-network

networks:
  app-network:
    external: true
EOL

# Create docker-compose.monitoring.yml
cat > docker-compose.monitoring.yml <<EOL
version: "3.8"
services:
  grafana:
    image: grafana/grafana:latest
    networks:
      - app-network
    ports:
      - "3000:3000"

  prometheus:
    image: prom/prometheus:latest
    networks:
      - app-network
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

networks:
  app-network:
    external: true
EOL

# Create docker-compose.keycloak.yml
cat > docker-compose.keycloak.yml <<EOL
version: "3.8"
services:
  keycloak:
    image: quay.io/keycloak/keycloak:latest
    environment:
      DB_VENDOR: POSTGRES
      DB_ADDR: postgres
      DB_DATABASE: keycloak
      DB_USER: keycloak
      DB_PASSWORD: password
      KEYCLOAK_USER: admin
      KEYCLOAK_PASSWORD: admin
    networks:
      - app-network
    ports:
      - "8080:8080"
    depends_on:
      - postgres

networks:
  app-network:
    external: true
EOL

# Create docker-compose.notification.yml
cat > docker-compose.notification.yml <<EOL
version: "3.8"
services:
  notification-service:
    image: jookies/jasmin:latest
    networks:
      - app-network

networks:
  app-network:
    external: true
EOL

# Create docker-compose.traefik.yml
cat > docker-compose.traefik.yml <<EOL
version: "3.8"
services:
  traefik:
    image: traefik:latest
    command:
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--entrypoints.web.address=:80"
    ports:
      - "80:80"
      - "8080:8080"
    networks:
      - app-network

networks:
  app-network:
    external: true
EOL

# Output message
echo "All docker-compose YAML files have been created successfully."
