# Docker-gcr

Docker-gcr is simple utility which allows you to push Docker images
dirrectly to Google Container registry. Target audience is Gitlab CI 
pipeline. 

[![](https://images.microbadger.com/badges/image/ackee/docker-gcr.svg)](https://microbadger.com/images/ackee/docker-gcr "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/ackee/docker-gcr.svg)](https://microbadger.com/images/ackee/docker-gcr "Get your own version badge on microbadger.com")

## Examples

Following example will build Docker image for `master` branch and publish it 
to your private GCR repository under name 
`eu.gcr.io/my-project-123/my-cool-image`. Image tag will be set to 
short SHA of the current commit. e.g. `53e3abc2`

```yaml
build:production:
  image: ackee/docker-gcr:v0.0.2
  stage: build
  variables:
    BUILD_VAULT_TOKEN: aaaabbbbddffff
    BUILD_GCLOUD_SA_VAULT_PATH: secret/data/bla/bla/bla
    BUILD_GCLOUD_SA_VAULT_KEY: SERVICE_ACCOUNT_KEY
    BUILD_VAULT_ADDR: https://vault.co.uk
  script:
    - gcr-init
    - docker build --build-arg SSH_KEY -t ${IMAGE_NAME}:${IMAGE_TAG} .
    - docker tag ${IMAGE_NAME}:${IMAGE_TAG} eu.gcr.io/${GCLOUD_PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}
    - docker push eu.gcr.io/${GCLOUD_PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}
  only:
    refs: ["master"]
    variables:
      - $CI_PIPELINE_SOURCE == "push"
```
