MAIN_VERSION:=$(shell git describe --abbrev=0 --tags || echo "0.1")
VERSION:=${MAIN_VERSION}\#$(shell git log -n 1 --pretty=format:"%h")
PACKAGES:=$(shell go list ./... | sed -n '1!p' | grep -v /vendor/)

default: run

depends:
	@echo "Install and/or update dependencies..."
	@dep ensure -v
	@echo "Dependencies updated... [DONE]"

run:
	@echo "Running kv-backup..."
	@go run ca.go consul_kv_backup.go

build: clean
	@go build -a -o ./bin/kv-backup ca.go consul_kv_backup.go
	@echo "Build binary...         [DONE]"

clean:
	@rm -rf ./bin/kv-backup
	@echo "Cleanup binary...       [DONE]"
