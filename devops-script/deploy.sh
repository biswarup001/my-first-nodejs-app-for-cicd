#!/bin/bash
# deploy.sh

set -e


# ------------------------
# Variables
# ------------------------
IMAGE_TAG=$1              
CONTAINER_NAME="node-app"
ENV_FILE="/home/ec2-user/.env"  


# ------------------------
# Install Docker if not present
# ------------------------
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing Docker..."
    # Update packages
    sudo dnf update -y
    # Install Docker
    sudo dnf install -y docker
    # Start Docker service
    sudo systemctl start docker
    sudo systemctl enable docker
    # Add ec2-user to docker group
    sudo usermod -aG docker ec2-user
    echo "Docker installed. You may need to re-login for group changes to take effect."
else
    echo "Docker is already installed."
fi


# ------------------------
# Check .env file exists
# ------------------------
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi



# ------------------------
# Pull the latest image
# ------------------------
echo "Pulling Docker image biswarup007/node-app:$IMAGE_TAG..."
docker pull biswarup007/node-app:$IMAGE_TAG


# ------------------------
# Stop and remove old container if exists
# ------------------------
echo "Stopping and removing old container (if exists)..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true


# ------------------------
# Run the new container
# ------------------------
docker run -d \
  --name $CONTAINER_NAME \
  --env-file $ENV_FILE \
  -p 80:3000 \
  biswarup007/node-app:$IMAGE_TAG

echo "Deployment complete: $CONTAINER_NAME running with image $IMAGE_TAG"