#!/bin/bash

rm -rf slurm-*.out
rm -rf build
mkdir -p build
pushd build

module load intel-oneapi-compilers/2023.0.0 intel-oneapi-tbb cuda/11.8.0
source ${INTEL_ONEAPI_COMPILERS_ROOT}/setvars.sh --include-intel-llvm --force
echo "Outside CMAKE: INTEL_ONEAPI_COMPILERS_ROOT = ${INTEL_ONEAPI_COMPILERS_ROOT}"
cmake -G "Unix Makefiles" -DINTEL_ONEAPI_COMPILERS_ROOT=${INTEL_ONEAPI_COMPILERS_ROOT} .. && make -j

popd