FROM ubuntu:16.04
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

RUN apt-get update && \
  apt-get install -y curl wget git unzip build-essential gcc zlib1g-dev libssl-dev ocaml libelf-dev language-pack-ja-base language-pack-en && \
  rm -rf /var/lib/apt/lists/*

# setup nodejs
ENV NODE_V=v8.1.0
ENV PATH=/usr/local/node-${NODE_V}-linux-x64/bin:$PATH
WORKDIR /usr/local
RUN wget -O - https://nodejs.org/download/release/${NODE_V}/node-${NODE_V}-linux-x64.tar.gz | tar zxf - && \
  npm i -g yarn

# setup golang
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/work/go
ENV PATH=$PATH:$GOPATH/bin
ENV GO_V=1.10
WORKDIR /usr/local
RUN wget -O - https://github.com/golang/go/archive/go${GO_V}.tar.gz | tar zxf -

# setup python
ENV PYTHONIOENCODING "utf-8"
ENV PYTHON_V 3.6.0
WORKDIR /root/
RUN wget -O - https://www.python.org/ftp/python/${PYTHON_V}/Python-${PYTHON_V}.tgz | tar zxf - && \
  cd Python-${PYTHON_V} && \
  ./configure && \
  make altinstall && \
  make clean && \
  pip3.6 install --upgrade pip && \
  pip3.6 install selenium && \
  pip3.6 install faker

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
