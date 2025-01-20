#!/bin/bash

# 변수 설정
DOCKER_IMAGE_NAME="lingua"
DOCKER_TAG="25.01"
BASE_DIR=$(pwd)
SQSH_FILE="${BASE_DIR}/${DOCKER_IMAGE_NAME}_${DOCKER_TAG}.sqsh"

# Docker 이미지 존재 확인
IMAGE_EXISTS=$(docker images -q ${DOCKER_IMAGE_NAME}:${DOCKER_TAG})

if [ -z "$IMAGE_EXISTS" ]; then
    # Step 1: Docker 이미지 빌드
    cd ..
    echo "Docker image ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} not found. Building image..."
    docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} -f "docker/Dockerfile" .
    cd docker
    if [ $? -ne 0 ]; then
        echo "Error: Docker build failed."
        exit 1
    fi
else
    echo "Docker image ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} already exists. Skipping build."
fi

# Step 2: sqsh 파일 생성
echo "Converting Docker image to sqsh format..."
enroot import --output $SQSH_FILE dockerd://${DOCKER_IMAGE_NAME}:${DOCKER_TAG}

if [ $? -eq 0 ]; then
    echo "Successfully created sqsh file: $SQSH_FILE"
else
    echo "Error: Failed to create sqsh file."
    exit 1
fi
