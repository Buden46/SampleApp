FROM ruby:2.3.7
ARG ssh_prv_key
ARG ssh_pub_key
RUN apt-get update && \
    apt-get install -y \
        git \
        openssh-server \
        default-libmysqlclient-dev
# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts
# Add the keys and set permissions
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub
RUN gem install bundler -v '1.17.3'
RUN apt-get install -y libicu-dev
RUN apt-get install -y libldap2-dev
RUN apt-get install -y libidn11-dev
RUN gem install idn-ruby -v '0.1.0'
RUN apt-get install -y cmake
RUN apt-get update
RUN apt-get install -y libcurl4-openssl-dev libgnutls28-dev libghc-hsopenssl-dev libghc-hsopenssl-dev libssl1.0-dev
RUN gem install cld2 -v '1.0.3' -- --with-cppflags=-DU_USING_ICU_NAMESPACE=1 --with-cxxflags=-std=c++03
RUN gem install rugged -v '0.28.5'
RUN gem install rack-ssl -v '1.3.4'
# Editor
WORKDIR /sample_app
EXPOSE 3000
