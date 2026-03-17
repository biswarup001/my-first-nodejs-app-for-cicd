#!/bin/bash
# deploy.sh

# Exit on any error
set -e

# Variables
IMAGE_TAG=$1              # Pass the image tag (short SHA) as argument
CONTAINER_NAME="node-app"
ENV_FILE="/home/ec2-user/.env"  # Path to your .env file on EC2

# Pull the latest image from Docker Hub
docker pull biswarup007/node-app:$IMAGE_TAG

# Stop and remove old container if it exists
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Run the new container
docker run -d \
  --name $CONTAINER_NAME \
  --env-file $ENV_FILE \
  -p 3000:3000 \
  biswarup007/node-app:$IMAGE_TAG

echo "Deployment complete: $CONTAINER_NAME running with image $IMAGE_TAG"