cmake_minimum_required(VERSION 3.25.0)
cmake_policy(VERSION 3.25.0)
include_guard(GLOBAL)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
include("${CMAKE_CURRENT_LIST_DIR}/ToolchainHelpers.cmake")
find_devkitpro()

set(CMAKE_SYSTEM_NAME GBA)
set(CMAKE_SYSTEM_PROCESSOR armv4t)
set(CMAKE_SYSTEM_VERSION 1)

set(triplet arm-none-eabi)
set(program_path "${DEVKITARM}/bin")

find_program(CMAKE_ASM_COMPILER ${triplet}-gcc NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_C_COMPILER ${triplet}-gcc NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_CXX_COMPILER ${triplet}-g++ NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_LINKER ${triplet}-ld NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_AR ${triplet}-gcc-ar NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_RANLIB ${triplet}-gcc-ranlib NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_STRIP ${triplet}-strip NO_DEFAULT_PATH PATHS ${program_path})
find_program(CMAKE_OBJCOPY ${triplet}-objcopy NO_DEFAULT_PATH PATHS ${program_path})
find_program(DKP_NM ${triplet}-nm NO_DEFAULT_PATH PATHS ${program_path})

find_program(
    GBA_GBAFIX_EXE
    NAMES gbafix
    NO_DEFAULT_PATH
    PATHS "${DEVKITPRO}/tools/bin"
)
