#!/bin/bash

rm -rf slurm-*.out
rm -rf build
mkdir -p build
pushd build

module load intel-oneapi-compilers/2023.0.0 intel-oneapi-tbb cuda/11.6.2
cmake -G "Unix Makefiles" .. && make -j45

popd