FROM ubuntu:16.04
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.com>

RUN apt-get update && \
  apt-get install -y curl wget git unzip build-essential gcc zlib1g-dev libssl-dev ocaml libelf-dev language-pack-ja-base language-pack-en && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# setup nodejs
ENV NODE_V=v8.9.4
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
RUN wget -O - https://storage.googleapis.com/golang/go${GO_V}.linux-amd64.tar.gz | tar zxf -

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
  pip3.6 install --no-cache-dir selenium && \
  pip3.6 install --no-cache-dir faker

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
