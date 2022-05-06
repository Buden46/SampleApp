FROM ruby:2.7.4
ARG ssh_prv_key
ARG ssh_pub_key
RUN apt-get update && \
    apt-get install -y \
        curl \
        build-essential \
        libpq-dev
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
#RUN apt-get install -y libicu-dev
#RUN apt-get install -y libldap2-dev
#RUN apt-get install -y libidn11-dev
#RUN apt-get install nodejs
#RUN gem install idn-ruby -v '0.1.0'
# RUN apt-get install -y cmake
RUN apt-get update
#RUN apt-get install -y libcurl4-openssl-dev libgnutls28-dev libghc-hsopenssl-dev libghc-hsopenssl-dev libssl1.1
#RUN gem install cld2 -v '1.0.3' -- --with-cppflags=-DU_USING_ICU_NAMESPACE=1 --with-cxxflags=-std=c++03
#RUN gem install rugged -v '0.28.5'
#RUN gem install rack-ssl -v '1.3.4'
# Editor
WORKDIR /sample_app
EXPOSE 3000

#docker build -t ruby-2.7.4 --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .
# docker run --name sample-app -p 3000:3000 -d -v "$(pwd)":/sample_app:delegated -it ruby-2.7.4
