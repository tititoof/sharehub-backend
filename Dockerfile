# syntax=docker/dockerfile:1

# https://github.com/tititoof/rails-7-docker-compose-template
FROM ruby:3.2.2-slim

# OS Level Dependencies
# RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
#     build-essential \
#     gnupg2 \
#     less \
#     git \
#     libpq-dev \
#     postgresql-client \
#     libvips \
#     curl \
#     vim \
#     libssl-dev \
#     libffi-dev \
#   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips \
    curl \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

ARG USERNAME=toofytroll
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN gem update --system && gem install bundler
RUN chown -Rf $USERNAME:$USERNAME /usr/local/bundle

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

WORKDIR /usr/src/app

ENTRYPOINT ["./bin/docker-entrypoint.sh"]

# [Optional] Set the default user. Omit if you want to keep the default as root.
# USER $USERNAME

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]