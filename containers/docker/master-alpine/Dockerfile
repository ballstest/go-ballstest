FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 --branch release/1.7 https://github.com/ballstest/go-ballstest && \
  (cd go-ballstest && make ballstest) && \
  cp go-ballstest/build/bin/ballstest /ballstest && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-ballstest && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/ballstest"]
