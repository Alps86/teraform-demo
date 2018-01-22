all: build

build:
	docker-compose up -d

build-app-image:
	docker build -t localhost:5000/app:latest -f Dockerfile .
	docker push localhost:5000/app:latest

teraform-init:
	docker-compose run --rm teraform init

teraform-apply:
	docker-compose run --rm teraform apply

teraform-destroy:
	docker-compose run --rm teraform destroy
