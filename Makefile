all:
	(cd opencv; make BASE_IMAGE=nvcr.io/nvidia/pytorch:21.10-py3)
	(cd ros; make)
	(cd dev; make)