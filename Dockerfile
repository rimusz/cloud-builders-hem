FROM gcr.io/google_containers/ubuntu-slim:0.14

MAINTAINER Rimas Mocevicius <rmocius@gmail.com>

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV DESIRED_VERSION _RELEASE_

RUN apt-get update && apt-get install --no-install-recommends -y \
  ca-certificates curl git \
  && rm -rf /var/tmp/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/archives/* \
  && curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get_helm.sh \
  && chmod 700 /tmp/get_helm.sh \
  && /tmp/get_helm.sh \
  && rm -rf /tmp/*

COPY /entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
