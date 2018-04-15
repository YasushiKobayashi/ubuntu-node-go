FROM ubuntu:16.04
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

RUN apt-get update && \
  apt-get install -y wget git unzip build-essential gcc zlib1g-dev libssl-dev

# setup nodejs
ENV NODE_V=v8.1.0
ENV PATH=/usr/local/node-${NODE_V}-linux-x64/bin:$PATH
WORKDIR /usr/local
RUN wget https://nodejs.org/download/release/${NODE_V}/node-${NODE_V}-linux-x64.tar.gz && \
  tar -zxvf node-${NODE_V}-linux-x64.tar.gz
RUN npm i -g yarn

# setup golang glide
WORKDIR /usr/local
ENV GO_V=1.10
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/work/go
ENV PATH=$PATH:$GOPATH/bin
RUN wget https://github.com/golang/go/archive/go${GO_V}.tar.gz && \
  tar -zxvf go${GO_V}.tar.gz

# setup python
WORKDIR /root/
RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz && \
  tar zxf Python-3.6.0.tgz && \
  cd Python-3.6.0 && \
  ./configure && \
  make altinstall
ENV PYTHONIOENCODING "utf-8"
RUN pip3.6 install selenium && \
  pip3.6 install faker

# setup lang ja
RUN apt-get update && \
  apt-get install -y language-pack-ja-base language-pack-en

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
