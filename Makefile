# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: ballstest android ios ballstest-cross swarm evm all test clean
.PHONY: ballstest-linux ballstest-linux-386 ballstest-linux-amd64 ballstest-linux-mips64 ballstest-linux-mips64le
.PHONY: ballstest-linux-arm ballstest-linux-arm-5 ballstest-linux-arm-6 ballstest-linux-arm-7 ballstest-linux-arm64
.PHONY: ballstest-darwin ballstest-darwin-386 ballstest-darwin-amd64
.PHONY: ballstest-windows ballstest-windows-386 ballstest-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

ballstest:
	build/env.sh go run build/ci.go install ./cmd/ballstest
	@echo "Done building."
	@echo "Run \"$(GOBIN)/ballstest\" to launch ballstest."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/ballstest.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/ballstest.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/jteeuwen/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go install ./cmd/abigen

# Cross Compilation Targets (xgo)

ballstest-cross: ballstest-linux ballstest-darwin ballstest-windows ballstest-android ballstest-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-*

ballstest-linux: ballstest-linux-386 ballstest-linux-amd64 ballstest-linux-arm ballstest-linux-mips64 ballstest-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-*

ballstest-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/ballstest
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep 386

ballstest-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/ballstest
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep amd64

ballstest-linux-arm: ballstest-linux-arm-5 ballstest-linux-arm-6 ballstest-linux-arm-7 ballstest-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep arm

ballstest-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/ballstest
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep arm-5

ballstest-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/ballstest
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep arm-6

ballstest-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/ballstest
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep arm-7

ballstest-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/ballstest
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep arm64

ballstest-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/ballstest
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep mips

ballstest-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/ballstest
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep mipsle

ballstest-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/ballstest
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep mips64

ballstest-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/ballstest
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-linux-* | grep mips64le

ballstest-darwin: ballstest-darwin-386 ballstest-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-darwin-*

ballstest-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/ballstest
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-darwin-* | grep 386

ballstest-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/ballstest
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-darwin-* | grep amd64

ballstest-windows: ballstest-windows-386 ballstest-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-windows-*

ballstest-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/ballstest
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-windows-* | grep 386

ballstest-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/ballstest
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/ballstest-windows-* | grep amd64
