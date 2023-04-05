// Copyright (C) 2020 Intel Corporation

// SPDX-License-Identifier: MIT

#include <sycl/sycl.hpp>
#include <iostream>
using namespace sycl;

const std::string secret {
    "Ifmmp-!xpsme\"\012J(n!tpssz-!Ebwf/!"
    "J(n!bgsbje!J!dbo(u!ep!uibu/!.!IBM\01" };

const auto sz = secret.size(); 

class Kernel;

int main() {
    std::cout << "Listing Available Platforms\n";

    for (auto platform : sycl::platform::get_platforms())
    {
        std::cout << "Platform: "
                  << platform.get_info<sycl::info::platform::name>()
                  << std::endl;

        for (auto device : platform.get_devices())
        {
            std::cout << "\tDevice: "
                      << device.get_info<sycl::info::device::name>()
                      << std::endl;
        }
    }


    std::cout << "Using the GPU Selctor\n";
    sycl::queue Q(sycl::gpu_selector_v);

    //std::cout << "Using the CPU (default) Selctor\n";
    //sycl::queue Q;

    std::cout << "Selctor chose: " << Q.get_device().get_info<sycl::info::device::name>() << std::endl;
    
    char *result = malloc_shared<char>(sz, Q);
    std::memcpy(result,secret.data(),sz);

    std::cout << "Launching kernel" << std::endl;
    Q.parallel_for(sz,[=](auto& i) {
        result[i] -= 1;
        }).wait();

    std::cout << result << "\n";
    free(result, Q);
    return 0;
}


