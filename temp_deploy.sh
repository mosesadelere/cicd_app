#!/bin/bash

# Deployment Script for a Containerized Application

# Variables
APP_NAME="my-app"
DOCKER_IMAGE="my-app:latest"
DOCKER_REGISTRY="my-docker-registry.com"
KUBE_NAMESPACE="default"
DEPLOYMENT_FILE="deployment.yaml"

# Functions
function build_image() {
    echo "Building Docker image..."
    docker build -t ${DOCKER_IMAGE} .
}

function push_image() {
    echo "Pushing Docker image to registry..."
    docker tag ${DOCKER_IMAGE} ${DOCKER_REGISTRY}/${DOCKER_IMAGE}
    docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}
}

function deploy_to_kubernetes() {
    echo "Deploying application to Kubernetes..."
    kubectl apply -f ${DEPLOYMENT_FILE} -n ${KUBE_NAMESPACE}
}

function check_deployment_status() {
    echo "Checking deployment status..."
    kubectl rollout status deployment/${APP_NAME} -n ${KUBE_NAMESPACE}
}

# Main Execution Flow
echo "Starting deployment process..."

build_image
if [ $? -ne 0 ]; then
    echo "Error: Docker image build failed."
    exit 1
fi

push_image
if [ $? -ne 0 ]; then
    echo "Error: Docker image push failed."
    exit 1
fi

deploy_to_kubernetes
if [ $? -ne 0 ]; then
    echo "Error: Kubernetes deployment failed."
    exit 1
fi

check_deployment_status
if [ $? -ne 0 ]; then
    echo "Error: Deployment rollout failed."
    exit 1
fi

echo "Deployment completed successfully!"
