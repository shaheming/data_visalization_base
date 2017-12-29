FROM ruby:2.3.1

RUN  mkdir -p /etc/apt/ \
    && sed -i 's#http://archive.ubuntu.com#http://mirrors.163.com#g' /etc/apt/sources.list


ENV BUNDLE_PATH /usr/local/bundle

RUN apt-get update -qq  \
    && apt-get install -y build-essential libpq-dev nodejs libmagickwand-dev

ARG WORKING_PATH
WORKDIR ${WORKING_PATH}

