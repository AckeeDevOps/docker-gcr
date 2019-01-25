#!/bin/sh

# Required variables:
#   GCLOUD_SA_KEY: base64 encoded string with service account key (cat /pat/to/key | base64 -w0)

# Check required variables
[ -z "$GCLOUD_SA_KEY" ] && { echo "GCLOUD_SA_KEY is required"; exit 1; }

echo "Initializing gcloud auth"
echo $GCLOUD_SA_KEY | base64 -d > /tmp/key.json
gcloud auth activate-service-account --key-file=/tmp/key.json

echo "Initializing Docker"
gcloud auth configure-docker -q