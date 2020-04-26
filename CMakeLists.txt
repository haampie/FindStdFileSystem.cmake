cmake_minimum_required(VERSION 3.0.0)

project(example)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

find_package(StdFileSystem REQUIRED)

add_executable(main main.cc)

target_link_libraries(main std::filesystem)
