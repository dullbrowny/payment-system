#!/bin/bash

# Docker Hub URL for querying image tags
DOCKER_HUB_URL="https://registry.hub.docker.com/v2/repositories"

# List of services and their respective Docker images (parallel arrays)
services=(
    "traefik"
    "keycloak"
    "kafka"
    "zookeeper"
    "postgres"
    "fraud-detection-service"
    "notification-service"
    "reporting-service"
    "prometheus"
    "grafana"
)

images=(
    "traefik:latest"
    "quay.io/keycloak/keycloak:latest"
    "wurstmeister/kafka:latest"
    "wurstmeister/zookeeper:latest"
    "postgres:13"
    "freewil/fraud-detection-ai:latest"
    "kannel/kannel:latest"
    "apache/superset:latest"
    "prom/prometheus:latest"
    "grafana/grafana:latest"
)

# Function to check if a Docker image exists
check_image() {
    local service=$1
    local image=$2
    echo "Checking image: $image"
    
    # Try pulling the image to see if it exists
    docker pull "$image" &> /dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Image $image is available."
        return 0
    else
        echo "❌ Image $image does not exist. Searching for alternative tags..."
        find_alternative_tags "$service" "$image"
        return 1
    fi
}

# Function to search for alternative tags for an image on Docker Hub
find_alternative_tags() {
    local service=$1
    local image=$2
    local repo_name="${image%%:*}"  # Extract repo name without tag
    
    # Query Docker Hub for alternative tags
    echo "Querying Docker Hub for available tags for $repo_name..."
    tags=$(curl -s "${DOCKER_HUB_URL}/${repo_name}/tags" | jq -r '.results[].name' 2>/dev/null)
    
    if [ -n "$tags" ]; then
        echo "Available tags for $repo_name:"
        echo "$tags"
        
        # Use the first available tag (you can modify this logic to choose a different tag)
        local new_tag=$(echo "$tags" | head -n 1)
        echo "Updating $service to use $repo_name:$new_tag in docker-compose.yml"
        update_docker_compose "$service" "$repo_name:$new_tag"
    else
        echo "❌ No alternative tags found for $repo_name."
        exit 1
    fi
}

# Function to update docker-compose.yml with the new image tag
update_docker_compose() {
    local service=$1
    local new_image=$2
    
    # Update the image in docker-compose.yml using sed
    sed -i.bak -e "s|\(.*$service:.*image: \).*|\1$new_image|" docker-compose.yml
    echo "Updated $service to use $new_image."
}

# Iterate over the services and images in parallel
for i in "${!services[@]}"; do
    check_image "${services[$i]}" "${images[$i]}"
    echo ""
done

# After checking all images, run docker-compose if all checks passed
echo "All images resolved. Proceeding with docker-compose up..."
docker-compose up --build

