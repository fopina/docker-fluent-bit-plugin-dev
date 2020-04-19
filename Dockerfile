FROM debian:stretch as builder

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      make \
      curl \
      unzip \
      libssl1.0-dev \
      libasl-dev \
      libsasl2-dev \
      pkg-config \
      libsystemd-dev \
      zlib1g-dev \
      flex \
      ca-certificates \
      bison \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/fluentbit

RUN curl -Lo /tmp/fluentbit.tgz \
         https://github.com/fluent/fluent-bit/archive/v1.4.2.tar.gz \
    && tar xf /tmp/fluentbit.tgz 

WORKDIR /usr/src/fluentbit/fluent-bit-1.4.2

RUN cmake .

WORKDIR /myplugin/build
