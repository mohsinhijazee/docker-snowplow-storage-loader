FROM java:7-jre

MAINTAINER Daniel Zohar <daniel@memrise.com>

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y build-essential bison openssl libreadline5 \
                          libreadline-dev curl git-core zlib1g zlib1g-dev libssl-dev \
                          libxslt-dev libxml2-dev libpq-dev subversion autoconf

RUN set -e && \
    apt-get update -y && \
    apt-get install -y make \
    build-essential \
    libpq-dev       \
    python-setuptools \
    python2.7-dev && \
    easy_install envtpl



# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && curl -L https://get.rvm.io | bash -s stable

# Install ruby, bundler
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 1.9.3 --default"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Checkout Snowplow repo
RUN git clone git://github.com/snowplow/snowplow.git

WORKDIR snowplow

WORKDIR 4-storage/storage-loader
RUN /bin/bash -l -c "bundle install --deployment"

# This runs fine but returning non zero code. Hence docker build fails. 
# So disbled for now.
#RUN /bin/bash -l -c "bundle exec bin/snowplow-storage-loader --version"

RUN mkdir /etc/snowplow/
COPY conf/config.yml.tpl /etc/snowplow/config.yml.tpl
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

