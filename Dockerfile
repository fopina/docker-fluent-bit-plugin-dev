FROM debian:bullseye as builder

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      make \
      curl \
      unzip \
      libssl-dev \
      libasl-dev \
      libsasl2-dev \
      pkg-config \
      libsystemd-dev \
      zlib1g-dev \
      flex \
      ca-certificates \
      bison \
      libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/fluentbit

ARG FLUENT_VERSION=1.9.10
ARG BUILD_DATE
ARG BUILD_VERSION

LABEL maintainer="github.com/fopina"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-url="https://github.com/fopina/docker-fluent-bit-plugin-dev"
LABEL org.label-schema.name="fopina/fluent-bit-plugin-dev"
LABEL org.label-schema.version=$BUILD_VERSION


RUN curl -Lo /tmp/fluentbit.tgz \
         https://github.com/fluent/fluent-bit/archive/v${FLUENT_VERSION}.tar.gz \
    && tar xf /tmp/fluentbit.tgz 

WORKDIR /usr/src/fluentbit/fluent-bit-${FLUENT_VERSION}

RUN cmake .

RUN ln -s /usr/src/fluentbit/fluent-bit-${FLUENT_VERSION}/ /usr/src/fluentbit/fluent-bit

WORKDIR /myplugin/build
