#!/bin/bash
# deploy.sh

set -e

IMAGE_TAG=$1              
CONTAINER_NAME="node-app"
ENV_FILE="/home/ec2-user/.env"  

docker pull biswarup007/node-app:$IMAGE_TAG

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

docker run -d \
  --name $CONTAINER_NAME \
  --env-file $ENV_FILE \
  -p 80:3000 \
  biswarup007/node-app:$IMAGE_TAG

echo "Deployment complete: $CONTAINER_NAME running with image $IMAGE_TAG"