#!/bin/bash

# First, concat the gitignore and custom.dockerignore modifiers into the final .dockerignore
cat .gitignore custom.dockerignore > .dockerignore

# Build the docker image
FILE="Dockerfile"
TAG="docker.home.spgill.me/key-server"
FROM="python:3.10-slim-bullseye"
# PUSH=false

docker rmi "$TAG:previous"
docker tag "$TAG:latest" "$TAG:previous"
docker pull "$FROM"
docker build --force-rm "$@" -f "$FILE" -t "$TAG:latest" .

# If push variable is "true", then push the image
if [ $PUSH = true ]; then
    docker push "$TAG:latest"
fi
