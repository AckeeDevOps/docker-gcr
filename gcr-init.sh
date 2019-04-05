#!/bin/sh

# Required variables:
#   BUILD_GCLOUD_SA_VAULT_PATH: Vault path. e.g. secret/data/projects/bla/bla
#   BUILD_GCLOUD_SA_VAULT_KEY: name of field with SA key e.g. SA_KEY, value should contain JSON formated SA key
#   BUILD_VAULT_TOKEN: Vault token in plain text

# Check required variables
[ -z "$BUILD_VAULT_TOKEN" ] && { echo "BUILD_VAULT_TOKEN is required"; exit 1; }
[ -z "$BUILD_GCLOUD_SA_VAULT_PATH" ] && { echo "BUILD_GCLOUD_SA_VAULT_PATH is required"; exit 1; }
[ -z "$BUILD_GCLOUD_SA_VAULT_KEY" ] && { echo "BUILD_GCLOUD_SA_VAULT_KEY is required"; exit 1; }

echo "Initializing gcloud auth"
# set Vault token for authentication
export VAULT_TOKEN="${BUILD_VAULT_TOKEN}"
# get Google SA key from Vault
vault read -format=json -field=data "${BUILD_GCLOUD_SA_VAULT_PATH}" | jq -r ".${BUILD_GCLOUD_SA_VAULT_KEY}" > /tmp/key.json
# activate service account
gcloud auth activate-service-account --key-file=/tmp/key.json

echo "Initializing Docker"
gcloud auth configure-docker -q
