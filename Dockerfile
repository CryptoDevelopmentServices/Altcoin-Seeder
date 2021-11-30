# ===============================================================================

# Set the base image to Ubuntu
# FROM ubuntu:16.04
FROM ubuntu:18.04
# FROM ubuntu:20.04

# File Author / Maintainer
MAINTAINER CryptoDevelopmentServices

# ===============================================================================
# Env. Setup
#

# Update repository
RUN apt-get update && apt-get -y upgrade

# ----------------------------------------------------------
# Dependencies
# ----------------------------------------------------------

# Basic Dependencies
#
RUN apt-get install -y git \
            telnet \
            unzip \
            build-essential \
            libboost-all-dev \
            libssl-dev \
            libtool \
            vim \
            curl \
            nginx
# ===============================================================================
# Set working directory
#
WORKDIR /work
COPY docker/nginx-default /etc/nginx/sites-enabled/default
# ===============================================================================
# Install configuration
#

# ===============================================================================
# System Initialization
#

## Copy folders

RUN git clone https://github.com/CryptoDevelopmentServices/Altcoin-Seeder.git /work
RUN cd /work && make

# Set default CMD
CMD service nginx start  && /work/dnsseed -h dnsseed.coin.cds -n ns.coin.cds -m dns@coin.cds

EXPOSE 53:53/udp