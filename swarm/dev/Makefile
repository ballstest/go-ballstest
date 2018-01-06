.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/ballstest/go-ballstest/cmd/swarm
	go build -o bin/ballstest     github.com/ballstest/go-ballstest/cmd/ballstest
	go build -o bin/bootnode github.com/ballstest/go-ballstest/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/ballstest/go-ballstest/swarm/...
