FROM alpine as base
WORKDIR /
RUN apk update && \
    apk add alpine-sdk cmake zlib-dev bzip2-dev python3 && \
    git clone https://github.com/nydus/storm-extract && \
    cd storm-extract && \
    git submodule init && \
    git submodule update && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

FROM scratch
COPY --from=base /storm-extract/build/bin/storm-extract /usr/bin/storm-extract
COPY --from=base /storm-extract/build/bin/libcasc.so.1 /usr/lib/libcasc.so.1
COPY --from=base /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=base /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6
COPY --from=base /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1
COPY --from=base /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=base /lib/libz.so.1 /lib/libz.so.1

ENTRYPOINT [ "storm-extract", "-i", "/input", "-o", "/output", "-x" ]