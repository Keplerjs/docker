FROM node:10-buster-slim

ARG METEOR_VERSION=1.8.1
ARG KEPLER_VERSION=1.7.1

ENV LC_ALL=POSIX \
    PATH=$PATH:/root/.meteor \
    METEOR_VERSION=$METEOR_VERSION \
    KEPLER_VERSION=$KEPLER_VERSION \
    ROOT_URL="http://localhost" \
    PORT=8800 \
    MONGO_URL="mongodb://0.0.0.0:27017/kepler"

RUN apt-get -yqq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yqq install \
        bash \
        curl \
        ca-certificates \
        bzip2 \
        unzip \
        imagemagick \
        jq \
        moreutils \
        g++ \
        make \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl "https://install.meteor.com/?release=${METEOR_VERSION}" | /bin/sh

RUN curl -Lo /tmp/kepler.zip "https://github.com/Keplerjs/Kepler/archive/refs/tags/v${KEPLER_VERSION}.zip"
RUN unzip -d /tmp /tmp/kepler.zip && mv /tmp/Kepler-${KEPLER_VERSION} /kepler-src
RUN rm /tmp/kepler.zip

WORKDIR /kepler-src
#COPY ./packages/demo ./packages/demo
COPY ./packages/keplerjs-googlemaps ./packages/keplerjs-googlemaps
COPY ./packages/keplerjs-openrouteservice ./packages/keplerjs-openrouteservice
COPY ./packages/keplerjs-wunderground ./packages/keplerjs-wunderground
COPY ./build.sh .
RUN chmod 0755 ./build.sh \
    && ./build.sh

WORKDIR /kepler

COPY ./docker-entrypoint.sh .
COPY ./env2settings.js .
COPY ./settings.json .

ENTRYPOINT ["/bin/bash"]
CMD ["/kepler/docker-entrypoint.sh"]
