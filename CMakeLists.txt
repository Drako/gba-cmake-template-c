cmake_minimum_required(VERSION 3.25)
cmake_policy(VERSION 3.25)
project(gba-cmake-template-c VERSION 0.1.0.0)

find_package(libtonc REQUIRED)

set(SOURCES main.c)
add_gba_executable(example
    ${SOURCES}
    PAD
)
target_link_libraries(example PRIVATE libtonc)
