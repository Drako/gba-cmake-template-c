cmake_minimum_required(VERSION 3.25.0)
cmake_policy(PUSH)
cmake_policy(VERSION 3.25.0)
include_guard(GLOBAL)

find_path(LIBTONC_INCLUDE_DIR
    NAMES tonc.h
    NO_DEFAULT_PATH
    PATHS "${DEVKITPRO}/libtonc"
    PATH_SUFFIXES include
)

find_library(LIBTONC_LIBRARY
    NAMES libtonc.a
    NO_DEFAULT_PATH
    PATHS "${DEVKITPRO}/libtonc"
    PATH_SUFFIXES lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Libtonc
    FOUND_VAR LIBTONC_FOUND
    REQUIRED_VARS LIBTONC_LIBRARY LIBTONC_INCLUDE_DIR
)

if (LIBTONC_FOUND)
  add_library(libtonc STATIC IMPORTED GLOBAL)
  set_target_properties(libtonc PROPERTIES IMPORTED_LOCATION "${LIBTONC_LIBRARY}")
  target_include_directories(libtonc INTERFACE "${LIBTONC_INCLUDE_DIR}")
  target_link_libraries(libtonc INTERFACE "${LIBTONC_LIBRARY}")
endif ()

cmake_policy(POP)
