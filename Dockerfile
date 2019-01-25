FROM docker:18.09.1

COPY gcr-init.sh /usr/local/bin/gcr-init

RUN echo installing gcloud SDK ... && \
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-230.0.0-linux-x86_64.tar.gz -O g.tar.gz > /dev/null 2>&1 && \
  tar -xvf g.tar.gz > /dev/null 2>&1 && \
  rm -rf g.tar.gz && \
  mkdir -p /opt && \
  mv google-cloud-sdk /opt/google-cloud-sdk && \
  apk add python > /dev/null 2>&1 && \
  /opt/google-cloud-sdk/install.sh -q > /dev/null 2>&1 && \
  gcloud config set component_manager/disable_update_check true > /dev/null 2>&1 && \
  echo installing ca-certificates ... && \
  apk add ca-certificates && \
  echo setting executable attributes ... && \
  chmod +x /usr/local/bin/gcr-init

ENV PATH="${PATH}:/opt/google-cloud-sdk/bin/"