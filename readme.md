![Build status](https://github.com/haampie/FindStdFileSystem.cmake/workflows/Build%20Linux,%20macOS,%20Windows/badge.svg)

# FindStdFileSystem

The situation with `std::filesystem` in C++ is a bit awkward, since different compilers require different compilation flags (`-lstdc++fs`, `-lc++fs`, or none).

This project provides a cmake file that adds an interface target to which you can link against. It will automatically set the right flags.

## Installation

Copy the contents of `cmake/` to your project.

Add `find_package(StdFileSystem)` to get the `std::filesystem` target.

Link your target via `target_link_libraries(my_target std::filesystem)`.

## Example

```cmake
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

find_package(StdFileSystem REQUIRED)

add_executable(main main.cc)

target_link_libraries(main std::filesystem)
```

## Caveats
Will only find `std::filesystem`, **not** `std::experimental::filesystem`.
