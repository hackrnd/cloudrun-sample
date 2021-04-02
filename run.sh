#!/bin/bash

export APP_NAME="my-web-app"
export IMAGE_NAME="gcr.io/${DEVSHELL_PROJECT_ID}/$APP_NAME:1"
export DATABASE_URL="postgres://user:password@host:port/db?ssl=true"
export GIT_URL="git-repo-with-dockerfile"

git clone $GIT_URL app
cd app/

gcloud builds submit --tag $IMAGE_NAME

gcloud beta run deploy app-$DEVSHELL_PROJECT_ID --image=$IMAGE_NAME --set-env-vars=DATABASE_URL=$DATABASE_URL --allow-unauthenticated --platform managed

gcloud container images delete $IMAGE_NAME
