TAG=24.06

all:
	(cd opencv; make BASE_IMAGE=nvcr.io/nvidia/pytorch:${TAG}-py3)
#	(cd ros; make)
	(cd dev; make)
