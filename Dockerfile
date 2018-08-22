FROM golang:alpine AS build-env

# https://gist.github.com/mapk0y/7ee356d5bb1d2ad06b52be1905edc3a6

RUN set -ex \
        && apk add --no-cache --virtual build-dependencies \
            build-base \
            git \
        && go get -ldflags "-extldflags -static" github.com/pressly/goose/cmd/goose \
        && apk del build-dependencies
        
        
FROM scratch

COPY --from=build-env /go/bin/goose /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/goose"]
CMD ["--help"]