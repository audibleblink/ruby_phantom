FROM ruby:slim
MAINTAINER github/audibleblink

# Install deps for bundle and npm
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  curl \
  git \
  make \
  build-essential \
  libfontconfig \
  && rm -rf /var/lib/apt/lists/*


WORKDIR /tmp
# Install node and npm
RUN bash -c 'curl -L https://git.io/n-install | bash -s -- -y'

# Ensure phantomjs is in PATH as well as node shims
ENV PATH $PATH:/root/n/bin
RUN npm config set user 0 \
  &&  npm config set unsafe-perm true \
  &&  npm install -g phantomjs-prebuilt

# Installs the webdriver and phantomjs wrapper
ADD Gemfile /tmp/
RUN bundle install && rm -rf /tmp/*

CMD ["pry"]
