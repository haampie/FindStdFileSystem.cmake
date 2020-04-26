SET(CXX_STANDARD 17)

if(TARGET std::filesystem)
    return()
endif()

# Try to compile a simple filesystem program without any linker flags
try_run(test_run_result
    test_compile_result 
    ${CMAKE_CURRENT_BINARY_DIR}/findfilesystem 
    ${CMAKE_CURRENT_LIST_DIR}/filesystem.cc 
    CXX_STANDARD 17
    COMPILE_OUTPUT_VARIABLE test_compile_output
    RUN_OUTPUT_VARIABLE test_run_output)

set(_found false)

if ("${test_compile_result}" AND ("${test_run_result}" EQUAL 0))
    set(_found true)
    set(CXX_FILESYSTEM_NO_LINK_NEEDED TRUE)
endif()

if (NOT _found)
    try_run(test_run_result
        test_compile_result 
        ${CMAKE_CURRENT_BINARY_DIR}/findfilesystem 
        ${CMAKE_CURRENT_LIST_DIR}/filesystem.cc 
        CXX_STANDARD 17
        LINK_LIBRARIES stdc++fs
        COMPILE_OUTPUT_VARIABLE test_compile_output
        RUN_OUTPUT_VARIABLE test_run_output)

    if ("${test_compile_result}" AND ("${test_run_result}" EQUAL 0))
        set(_found true)
        set(CXX_FILESYSTEM_STDCPPFS_NEEDED TRUE)
    endif()
endif()

if (NOT _found)
    try_run(test_run_result
        test_compile_result 
        ${CMAKE_CURRENT_BINARY_DIR}/findfilesystem 
        ${CMAKE_CURRENT_LIST_DIR}/filesystem.cc 
        CXX_STANDARD 17
        LINK_LIBRARIES c++fs
        COMPILE_OUTPUT_VARIABLE test_compile_output
        RUN_OUTPUT_VARIABLE test_run_output)

    if ("${test_compile_result}" AND ("${test_run_result}" EQUAL 0))
        set(_found true)
        set(CXX_FILESYSTEM_CPPFS_NEEDED TRUE)
    endif()
endif()

if(_found)
    add_library(std::filesystem INTERFACE IMPORTED)
    target_compile_features(std::filesystem INTERFACE cxx_std_17)

    if(CXX_FILESYSTEM_STDCPPFS_NEEDED)
        target_link_libraries(std::filesystem INTERFACE -lstdc++fs)
    elseif(CXX_FILESYSTEM_CPPFS_NEEDED)
        target_link_libraries(std::filesystem INTERFACE -lc++fs)
    endif()
endif()

set(StdFileSystem_FOUND ${_found} CACHE BOOL "TRUE if we can compile and link a program using std::filesystem" FORCE)

if(StdFileSystem_FIND_REQUIRED AND NOT StdFileSystem_FOUND)
    message(FATAL_ERROR "Cannot Compile simple program using std::filesystem")
endif()
