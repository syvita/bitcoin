FROM ubuntu:18.04
MAINTAINER Florent Dufour "florent.dufour@univ-lorraine.fr"

ENV bitcoinVersion=0.18.1

#ARG CHAIN # regtest, tesnet, mainnet

RUN apt-get update -y
RUN apt-get install -y locales git wget
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install -y libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev

# config system
#default to UTF8 character set (avoid ascii decode exceptions raised by python)
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_TYPE en_US.UTF-8
RUN locale-gen en_US.UTF-8

# Checkout bitcoin source
WORKDIR /tmp
RUN git clone --verbose https://github.com/bitcoin/bitcoin.git bitcoin/
#RUN git clone -b ${bitcoinVersion} https://github.com/bitcoin/bitcoin.git bitcoin/

# Install Berkley Database
RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz && tar -xvf db-4.8.30.NC.tar.gz
WORKDIR /tmp/db-4.8.30.NC/build_unix
RUN mkdir -p build
RUN BDB_PREFIX=$(pwd)/build
RUN ../dist/configure --disable-shared --enable-cxx --with-pic --prefix=$BDB_PREFIX
RUN make install

# Install bitcoin
WORKDIR /tmp/bitcoin
RUN git checkout tags/v0.18.1
RUN ./autogen.sh \
  && ./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2" LDFLAGS="-L${BDB_PREFIX}/lib/" --without-gui
RUN make \
  && make install

# System config
RUN echo "alias log=tail -f /root/.bitcoin/debug.log" >> /root/.bashrc

# Cleanup
RUN apt-get autoremove -y
RUN rm -rf /tmp/* \
  && rm -rf /root/.cache  \
  && rm -rf /var/cache/* \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

WORKDIR /
ENTRYPOINT bash && bitcoind
