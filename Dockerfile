# =============================================================================
# Target: base
#

FROM ruby:2.6.4-alpine AS base

# =============================================================================
# Global configuration

ENV APP_USER=test
ENV APP_UID=40040

# Create the application user/group and installation directory
RUN addgroup -S -g $APP_UID $APP_USER && \
    adduser -S -u $APP_UID -G $APP_USER $APP_USER && \
    mkdir -p /opt/app /var/opt/app && \
    chown -R $APP_USER:$APP_USER /opt/app /var/opt/app /usr/local/bundle

# Install packages common to dev and prod.
RUN apk --no-cache --update upgrade && \
    apk --no-cache add \
        bash \
        ca-certificates \
        git \
        libc6-compat \
        nodejs \
        openssl \
        sqlite-libs \
        tzdata \
        xz-libs \
        yarn && \
    rm -rf /var/cache/apk/*

# All subsequent commands are executed relative to this directory.
WORKDIR /opt/app

# Run as the app user to minimize risk to the host.
USER $APP_USER

# Environment
ENV PATH="/opt/app/bin:$PATH" \
    RAILS_LOG_TO_STDOUT=yes

# Entrypoint: a thin wrapper script that just passes all its arguments t
# Rails, e.g.
#
#   docker run <image> assets:precompile db:create db:migrate
ENTRYPOINT ["/opt/app/bin/docker-entrypoint.sh"]

# Sets "server" as the default command. If you docker-run this image with no
# additional arguments, it simply starts the server.
CMD ["server"]

# =============================================================================
# Target: development
#

FROM base AS development

# Temporarily switch back to root to install build packages.
USER root

# Install system packages needed to build gems with C extensions.
RUN apk --update --no-cache add \
        build-base \
        coreutils \
        git \
        sqlite-dev && \
    rm -rf /var/cache/apk/*

# Drop back to app user
USER $APP_USER

# The base image ships bundler 1.17.2, but on macOS, Ruby 2.6.4 comes with
# bundler 1.17.3 as a default gem, and there's no good way to downgrade.
RUN gem install bundler -v 1.17.3

# Install gems. We do this first in order to maximize cache reuse, and we
# do it only in the development image in order to minimize the size of the
# final production image (which just copies the build products from dev)
COPY --chown=$APP_USER Gemfile* ./
RUN bundle install --jobs=$(nproc) --deployment --path=/usr/local/bundle

# Copy the rest of the codebase.
COPY --chown=$APP_USER . .

