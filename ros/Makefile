
2004:
	docker build -t dtmoodie:ros-2004 . \
		--build-arg from=opencv \
		--build-arg distro=noetic \
		--build-arg ARCH=$(shell nvidia-container-cli info | grep -oP '(?<=Architecture:).*' | grep -o '\w*\.\w*' | sort -u | xargs | tr ' ' ',')