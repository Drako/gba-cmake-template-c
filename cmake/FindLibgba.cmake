cmake_minimum_required(VERSION 3.25.0)
cmake_policy(PUSH)
cmake_policy(VERSION 3.25.0)
include_guard(GLOBAL)

find_path(LIBGBA_INCLUDE_DIR
    NAMES gba.h
    NO_DEFAULT_PATH
    PATHS "${DEVKITPRO}/libgba"
    PATH_SUFFIXES include
)

find_library(LIBGBA_LIBRARY
    NAMES libgba.a
    NO_DEFAULT_PATH
    PATHS "${DEVKITPRO}/libgba"
    PATH_SUFFIXES lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    libgba
    FOUND_VAR LIBGBA_FOUND
    REQUIRED_VARS LIBGBA_LIBRARY LIBGBA_INCLUDE_DIR
)

if (LIBGBA_FOUND)
  add_library(libgba STATIC IMPORTED GLOBAL)
  set_target_properties(libgba PROPERTIES IMPORTED_LOCATION "${LIBGBA_LIBRARY}")
  target_include_directories(libgba INTERFACE "${LIBGBA_INCLUDE_DIR}")
  target_link_libraries(libgba INTERFACE "${LIBGBA_LIBRARY}")
endif ()

cmake_policy(POP)
