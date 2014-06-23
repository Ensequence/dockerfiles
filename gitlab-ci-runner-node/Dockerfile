# gitlab-ci-runner-node

FROM ubuntu:12.04
MAINTAINER  John Weis "weis.john@gmail.com"

# Based on https://github.com/gitlabhq/gitlab-ci-runner/blob/master/Dockerfile
# by Sytse Sijbrandij <sytse@gitlab.com>
# and on https://github.com/bkw/gitlab-ci-runner-nodejs/blob/master/Dockerfile
# by Bernhard Weisshuhn <bkw@codingforce.com>

# This script will start a runner in a docker container.
#
# First build the container and give a name to the resulting image:
# docker build -t weisjohn/gitlab-ci-runner-node github.com/bkw/gitlab-ci-runner-nodejs
#
# Then set the environment variables and run the gitlab-ci-runner in the container:
# docker run -e CI_SERVER_URL=https://ci.example.com -e REGISTRATION_TOKEN=replaceme -e HOME=/root -e GITLAB_SERVER_FQDN=gitlab.example.com weisjohn/gitlab-ci-runner-node
#
# After you start the runner you can send it to the background with ctrl-z
# The new runner should show up in the GitLab CI interface on /runners
#
# You can start an interactive session to test new commands with:
# docker run -e CI_SERVER_URL=https://ci.example.com -e REGISTRATION_TOKEN=replaceme -e HOME=/root -i -t weisjohn/gitlab-ci-runner-node:latest /bin/bash
#
# If you ever want to freshly rebuild the runner please use:
# docker build -no-cache -t weisjohn/gitlab-ci-runner-node github.com/bkw/gitlab-ci-runner-nodejs

# Update your packages and install the ones that are needed to compile Ruby
RUN apt-get update -y
RUN apt-get install -y wget curl gcc libxml2-dev libxslt-dev libcurl4-openssl-dev libreadline6-dev libc6-dev libssl-dev make build-essential zlib1g-dev openssh-server git-core libyaml-dev postfix libpq-dev libicu-dev

# Install a lighter version of Ruby
RUN mkdir /tmp/ruby && cd /tmp/ruby && curl --progress http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz | tar xz
RUN cd /tmp/ruby/ruby-1.9.3-p392 && ./configure --disable-install-rdoc && make && make install

# Prepare a known host file for non-interactive ssh connections
RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/known_hosts

# Install the runner
RUN git clone https://github.com/gitlabhq/gitlab-ci-runner.git /gitlab-ci-runner

# Install the gems for the runner
RUN cd /gitlab-ci-runner && gem install bundler && bundle install

# Install some usefull gems for web development
RUN gem install compass sass

# Download a pre-built Node.js and install it
RUN mkdir node && cd node && curl -s http://nodejs.org/dist/v0.10.29/node-v0.10.29-linux-x64.tar.gz | tar xz --strip-components=1 && mv ./bin/* /usr/local/bin/. && mv ./lib/* /usr/local/lib/.

# update npm and install some basics
RUN npm install -g phantomjs bower mocha uglifyjs

# When the image is started add the remote server key, install the runner and run it
WORKDIR /gitlab-ci-runner
CMD bundle exec ./bin/runner
