#!/bin/bash

# List of Docker images for services
services=(
    "traefik:latest"
    "quay.io/keycloak/keycloak:latest"
    "wurstmeister/kafka:latest"
    "wurstmeister/zookeeper:latest"
    "postgres:13"
    "openbank/fraud-ar:latest"
    "xrowgmbh/kannel:latest"
    "apache/superset:latest"
    "prom/prometheus:latest"
    "grafana/grafana:latest"
)

# Function to check image availability and capture detailed error if failed
check_image() {
    image_name=$1
    echo "Checking image: $image_name"
    
    # Attempt to pull the image and capture the output and error message
    pull_output=$(docker pull $image_name 2>&1)
    
    if [ $? -eq 0 ]; then
        echo "✅ Image $image_name is available."
    else
        echo "❌ Error pulling image $image_name. Here is the error message:"
        echo "$pull_output"
    fi
}

# Iterate over the services list and check each one
for image in "${services[@]}"; do
    check_image "$image"
    echo ""
done

echo "Image availability check complete."

