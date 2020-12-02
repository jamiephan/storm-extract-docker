FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install cmake \
                libbz2-dev \
                zlib1g-dev \
                python \
                git \
                build-essential -y && \
    cd /root && \
    git clone https://github.com/nydus/storm-extract && \
    cd storm-extract && \
    git submodule init && \
    git submodule update && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cd bin && \
    cp storm-extract /usr/bin/ && \
    cp libcasc.* /usr/local/lib/ && \
    cd /root && \
    rm -rf storm-extract && \
    DEBIAN_FRONTEND=noninteractive apt purge cmake \
            libbz2-dev \
            zlib1g-dev \
            python \
            git \
            build-essential -y && \
    DEBIAN_FRONTEND=noninteractive apt autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt autoclean -y && \
    DEBIAN_FRONTEND=noninteractive apt clean -y && \
    rm -rf /var/lib/apt/lists/*

# VOLUME [ "/input", "/output" ]

ENTRYPOINT [ "storm-extract", "-i", "/input", "-o", "/output", "-x" ]