FROM ubuntu:14.04.3
MAINTAINER Upendra Devisetty <upendra@cyverse.org>
LABEL Description "This Dockerfile is for QUAST-4.0"

RUN apt-get update 

# Dependencies
RUN apt-get install -y g++ \
                          make \
                          wget \
                          python \
                          python-matplotlib \
                          zlib1g-dev \
                          cmake \
                          openjdk-6-jdk \
                          curl \
                          libboost-all-dev \   
                          libncurses5-dev

# cpanm modules
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Time::HiRes

# Clone Quast git repo
RUN wget -O- https://github.com/ablab/quast/archive/release_4.0.tar.gz | tar zxvf -
RUN chmod +x /quast-release_4.0/quast.py

# configure samtools
WORKDIR /quast-release_4.0/libs/samtools
RUN ./configure && make && make install

# Specify entrypoint
ENTRYPOINT ["/quast-release_4.0/quast.py"]
CMD ["-h"]
