FROM node:9.11-alpine
MAINTAINER github/audibleblink

# Install deps for bundle and npm
RUN apk add --no-cache ruby-dev ruby-bundler ruby-irb ruby-json make g++ zlib-dev curl

# Alpine/PhantomJS Bug: https://github.com/ariya/phantomjs/issues/14186#issuecomment-381924432
RUN  curl -Ls "https://github.com/dustinblackman/phantomized/releases/download/2.1.1/dockerized-phantomjs.tar.gz" | tar xz -C / \
  && npm config set user 0 \
  && npm install -g phantomjs-prebuilt

# Installs the webdriver and phantomjs wrapper
WORKDIR /tmp
ADD Gemfile /tmp/
RUN bundle install

RUN apk del curl make g++ zlib-dev \
  && rm -rf /usr/share/man /var/tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /tmp/* /usr/local/lib/node_modules/npm \

CMD ["pry"]
