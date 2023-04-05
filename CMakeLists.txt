cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

set(CMAKE_CXX_COMPILER icpx)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


if (NOT CMAKE_BUILD_TYPE)
    message(STATUS "No build type selected, default to Release")
    set(CMAKE_BUILD_TYPE "Release" CACHE PATH "Build Type" FORCE)
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

project(cnnCudaVsSycl)


if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/install" CACHE PATH "Install Path" FORCE)
endif()


function(add_book_sample)

    set(options TEST)
    set(one_value_args TARGET)
    set(multi_value_args SOURCES LIBS ADDITIONAL_COMPILE_OPTIONS)
    cmake_parse_arguments(BOOK_SAMPLE
        "${options}" "${one_value_args}" "${multi_value_args}"
        ${ARGN}
    )

    add_executable(${BOOK_SAMPLE_TARGET} ${BOOK_SAMPLE_SOURCES})

    target_compile_options(${BOOK_SAMPLE_TARGET} PRIVATE -fsycl -fsycl-unnamed-lambda -ferror-limit=1 -Wall -Wpedantic ${BOOK_SAMPLE_ADDITIONAL_COMPILE_OPTIONS})

    target_link_libraries(${BOOK_SAMPLE_TARGET} PRIVATE ${BOOK_SAMPLE_LIBS} -fsycl)

    if(CMAKE_CONFIGURATION_TYPES)
        set(BOOK_SAMPLE_CONFIGS ${CMAKE_CONFIGURATION_TYPES})
    else()
        set(BOOK_SAMPLE_CONFIGS ${CMAKE_BUILD_TYPE})
    endif()
    foreach(CONFIG ${BOOK_SAMPLE_CONFIGS})
        install(TARGETS ${BOOK_SAMPLE_TARGET} CONFIGURATIONS ${CONFIG} DESTINATION ${CONFIG})
    endforeach()
    if(BOOK_SAMPLE_TEST)
        add_test(NAME ${BOOK_SAMPLE_TARGET} COMMAND ${BOOK_SAMPLE_TARGET})
    endif()
endfunction()

add_book_sample(
    TEST
    TARGET cnnSycl
    SOURCES cnn.cpp)