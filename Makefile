VERSION ?= 1.0.0
PREFIX = radarion/lightning-prometheus-exporter
TAG = $(VERSION)
GIT_COMMIT = $(shell git rev-parse --short HEAD)

default:
	CGO_ENABLED=0 go build -installsuffix cgo -ldflags "-X main.version=$(VERSION) -X main.gitCommit=$(GIT_COMMIT)" -o exporter

test:
	go test ./...

container:
	docker build --build-arg VERSION=$(VERSION) --build-arg GIT_COMMIT=$(GIT_COMMIT) -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

docker:
	docker build --build-arg VERSION=$(VERSION) --build-arg GIT_COMMIT=$(GIT_COMMIT) -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)


clean:
	-rm exporter
	-rm lightning-prometheus-exporter

