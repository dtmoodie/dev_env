BASE_IMAGE?=nvcr.io/nvidia/pytorch:22.10-py3
all:
	docker build . -t opencv_builder --build-arg BASE_IMAGE=$(BASE_IMAGE)
