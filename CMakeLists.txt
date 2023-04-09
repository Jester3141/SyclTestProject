cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

set(CMAKE_CXX_COMPILER clang++)

project(cnn-app)


if(NOT DEFINED INTEL_ONEAPI_COMPILERS_ROOT)
    message(FATAL_ERROR "INTEL_ONEAPI_COMPILERS_ROOT variable was not set.  Be sure and pass it in with a cmake -DINTEL_ONEAPI_COMPILERS_ROOT=<DIR>")
endif()

message(STATUS "INTEL_ONEAPI_COMPILERS_ROOT: ${INTEL_ONEAPI_COMPILERS_ROOT}")

find_package(IntelDPCPP REQUIRED)

message(STATUS "SYCL_LANGUAGE_VERSION: ${SYCL_LANGUAGE_VERSION}")
message(STATUS "SYCL_INCLUDE_DIR: ${SYCL_INCLUDE_DIR}")
message(STATUS "SYCL_LIBRARY_DIR: ${SYCL_LIBRARY_DIR}")


add_executable(cnn-app cnn.cpp)

target_compile_options(cnn-app PRIVATE -fsycl-targets=nvptx64-nvidia-cuda)
target_link_options(cnn-app PRIVATE -fsycl-targets=nvptx64-nvidia-cuda)
