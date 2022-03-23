TAG=21.10

all:
	(cd opencv; make BASE_IMAGE=nvcr.io/nvidia/pytorch:${TAG}-py3)
	(cd ros; make)
	(cd dev; make)
