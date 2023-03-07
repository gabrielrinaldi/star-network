# Base image
ARG RUBY_VERSION=3.2.1
ARG VARIANT=slim-bullseye

FROM ruby:${RUBY_VERSION}-${VARIANT} as base

ARG BUNDLE_PATH=vendor/bundle
ARG BUNDLE_WITHOUT=development:test
ARG RAILS_ENV=production

ENV BUNDLE_PATH ${BUNDLE_PATH}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV RAILS_ENV=${RAILS_ENV}

RUN mkdir /app

WORKDIR /app

RUN mkdir -p tmp/pids

# Build dependencies
FROM base as build_deps

ARG DEV_PACKAGES="git build-essential libvips libpq-dev wget vim curl gzip xz-utils"

ENV DEV_PACKAGES ${DEV_PACKAGES}

RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
  --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
  apt-get update -qq && \
  apt-get install --no-install-recommends -y ${DEV_PACKAGES} && \
  rm -rf /var/lib/apt/lists /usr/share/doc /usr/share/man /var/cache/apt/archives

# Build gems
FROM build_deps as gems

ARG BUNDLER_VERSION=2.4.7

ENV BUNDLER_VERSION ${BUNDLER_VERSION}

RUN gem install -N bundler -v ${BUNDLER_VERSION}

COPY Gemfile* ./
RUN bundle install && rm -rf vendor/bundle/ruby/*/cache

# Production image
FROM base

ARG NODE_MAJOR_VERSION=19
ARG PROD_PACKAGES="libvips nodejs npm postgresql-client file vim curl gzip wget xz-utils"
ARG SERVER_COMMAND="bin/rails fly:server"

ENV PORT 8080
ENV PROD_PACKAGES=${PROD_PACKAGES}
ENV SERVER_COMMAND ${SERVER_COMMAND}

RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR_VERSION.x | bash -
RUN --mount=type=cache,id=prod-apt-cache,sharing=locked,target=/var/cache/apt \
  --mount=type=cache,id=prod-apt-lib,sharing=locked,target=/var/lib/apt \
  apt-get update -qq && \
  apt-get install --no-install-recommends -y ${PROD_PACKAGES} && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists /usr/share/doc /usr/share/man /var/cache/apt/archives

RUN npm install -g mjml

COPY . .

COPY --from=gems /app /app

RUN bundle exec bootsnap precompile --gemfile app/ lib/

RUN SECRET_KEY_BASE=1 bin/rails fly:build

EXPOSE ${PORT}

CMD ${SERVER_COMMAND}
