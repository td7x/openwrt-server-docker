default: dev

build:
	@docker build -t td7x/openwrt .

dev: build
	docker run --rm -it --name ow-dev td7x/openwrt /bin/ash



# login:
# 	@docker login

# push:
# 	@docker push td7x/openwrt
