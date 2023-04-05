SHELL := /bin/bash

all: 


	module load intel-oneapi-compilers/2023.0.0 intel-oneapi-tbb cuda/11.8.0
	source ${INTEL_ONEAPI_COMPILERS_ROOT}/setvars.sh --include-intel-llvm --force
	clang++ -fsycl -fsycl-targets=nvptx64-nvidia-cuda cnn.cpp -o cnn-app
	printf "Running program\n\n"
	./cnn-app




