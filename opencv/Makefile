BASE_IMAGE?=nvcr.io/nvidia/pytorch:21.10-py3
all:
	(cd stage0; make BASE_IMAGE=$(BASE_IMAGE))
	(cd stage1; make BASE_IMAGE=$(BASE_IMAGE))