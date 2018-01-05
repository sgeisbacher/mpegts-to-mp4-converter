default: build

build:
	docker build -t handbrake-cli -f ./Dockerfile.handbrake-cli . 
	docker build -t mpegts-to-mp4-converter .
