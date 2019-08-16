FROM ubuntu:18.04

LABEL maintainer="SKWCRD <skw.crd.05@gmail.com>"

ENV FLUTTER_HOME ${HOME}/flutter
ENV FLUTTER_VERSION 1.7.8+hotfix.4-stable

RUN apt-get update \
  && apt-get install -y libglu1-mesa git curl unzip wget xz-utils lib32stdc++6 \
  && apt-get clean

RUN wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${FLUTTER_VERSION}.tar.xz
RUN cd ${HOME} & tar xf /flutter_linux_v${FLUTTER_VERSION}.tar.xz

ENV PATH ${PATH}:${FLUTTER_HOME}/bin

WORKDIR /