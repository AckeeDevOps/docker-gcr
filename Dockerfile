# in case of update please
#   - change the version of Docker baseline (line 7)
#   - change the version of gcloud SDK (line 12)
#   - change the version of Vault client (line 21)
#     https://cloud.google.com/sdk/docs/release-notes

FROM docker:18.09.1

COPY gcr-init.sh /usr/local/bin/gcr-init

RUN echo "installing gcloud SDK ..." && \
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-230.0.0-linux-x86_64.tar.gz -O g.tar.gz > /dev/null 2>&1 && \
  tar -xvf g.tar.gz > /dev/null 2>&1 && \
  rm -rf g.tar.gz && \
  mkdir -p /opt && \
  mv google-cloud-sdk /opt/google-cloud-sdk && \
  apk add python > /dev/null 2>&1 && \
  /opt/google-cloud-sdk/install.sh -q > /dev/null 2>&1 && \
  /opt/google-cloud-sdk/bin/gcloud config set component_manager/disable_update_check true > /dev/null 2>&1 && \
  echo "installing vault client ..." && \
  wget https://releases.hashicorp.com/vault/1.1.0/vault_1.1.0_linux_amd64.zip -O v.zip  > /dev/null 2>&1 && \
  unzip v.zip > /dev/null 2>&1 && \
  rm -rf v.zip > /dev/null 2>&1 && \
  mv vault /usr/local/bin/vault && \
  echo "installing ca-certificates ..." && \
  apk add ca-certificates > /dev/null 2>&1 && \
  echo "installing other tools ..." && \
  apk add openssl > /dev/null 2>&1 && \
  apk add jq > /dev/null 2>&1 && \
  echo "setting executable attributes ..." && \
  chmod +x /usr/local/bin/gcr-init

ENV PATH="${PATH}:/opt/google-cloud-sdk/bin/"
