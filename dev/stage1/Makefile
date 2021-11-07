all:
	cp ~/.ssh/id_rsa.pub authorized_keys
	docker build -t dtmoodie:dev-2004 . \
		--build-arg user=$(USER) \
		--build-arg uid=$(shell id -u $(USER)) \
		--build-arg gid=$(shell id -g $(USER)) \
		--build-arg useremail=$(shell git config --global user.email) \
		--build-arg username="$(shell git config --global user.name)"