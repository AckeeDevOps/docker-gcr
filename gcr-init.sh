#!/bin/sh

# Required variables:
#   BUILD_GCLOUD_SA_VAULT_PATH: Vault path. e.g. secret/data/projects/bla/bla
#   BUILD_GCLOUD_SA_VAULT_KEY: name of field with SA key e.g. SA_KEY, value should contain JSON formated SA key
#   BUILD_VAULT_TOKEN: Vault token in plain text

# Check required variables
[ -z "$VAULT_TOKEN" ] && { echo "VAULT_TOKEN is required"; exit 1; }
[ -z "$VAULT_ADDR" ] && { echo "VAULT_ADDR is required"; exit 1; }
[ -z "$VAULT_GCP_SA_PATH" ] && { echo "VAULT_GCP_SA_PATH is required"; exit 1; }
[ -z "$VAULT_GCP_SA_KEY" ] && { echo "VAULT_GCP_SA_KEY is required"; exit 1; }

echo "Initializing gcloud auth"
# get Google SA key from Vault
vault read -format=json -field=data "${VAULT_GCP_SA_PATH}" | jq -r ".${VAULT_GCP_SA_KEY}" > /tmp/key.json
# activate service account
gcloud auth activate-service-account --key-file=/tmp/key.json

echo "Initializing Docker"
gcloud auth configure-docker -q
