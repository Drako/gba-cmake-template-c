cmake_minimum_required(VERSION 3.25.0)
cmake_policy(VERSION 3.25.0)
include_guard(GLOBAL)

set(CMAKE_EXECUTABLE_SUFFIX .elf)

function(add_gba_library target)
  add_library(${target} STATIC ${ARGN})
  target_compile_options(${target} PRIVATE
      -march=armv4t -mtune=arm7tdmi -mthumb -mthumb-interwork
      -ffunction-sections -fdata-sections -D__GBA__ -DARM7
  )
  target_link_options(${target} PRIVATE
      -ffunction-sections -fdata-sections -D__GBA__ -DARM7
      -specs=gba.specs
  )
endfunction()

function(add_gba_executable target)
  set(GBA_FLAGS PAD)
  set(GBA_SINGLE_ARG VERSION TITLE GAMECODE MAKERCODE ROMNAME)
  set(GBA_MULTI_ARG)
  cmake_parse_arguments(PARSE_ARGV 1 GBA "${GBA_FLAGS}" "${GBA_SINGLE_ARG}" "${GBA_MULTI_ARG}")

  add_executable(${target} ${GBA_UNPARSED_ARGUMENTS})
  target_compile_options(${target} PRIVATE
      -march=armv4t -mtune=arm7tdmi -mthumb -mthumb-interwork
      -ffunction-sections -fdata-sections -D__GBA__ -DARM7
  )
  target_link_options(${target} PRIVATE
      -ffunction-sections -fdata-sections -D__GBA__ -DARM7
      -specs=gba.specs
  )

  if (DEFINED GBA_ROMNAME)
    set(GBA_OUTPUT "${GBA_ROMNAME}")
  else ()
    get_target_property(dir ${target} BINARY_DIR)
    get_target_property(output_name ${target} OUTPUT_NAME)
    if (NOT output_name)
      set(output_name "${target}")
    endif ()

    set(GBA_OUTPUT "${dir}/${output_name}.gba")
  endif ()

  set(GBAFIX_ARGS)
  if (GBA_PAD)
    list(APPEND GBAFIX_ARGS "-p")
  endif ()
  if (DEFINED GBA_TITLE)
    list(APPEND GBAFIX_ARGS "-t${GBA_TITLE}")
  endif ()
  if (DEFINED GBA_GAMECODE)
    list(APPEND GBAFIX_ARGS "-c${GBA_GAMECODE}")
  endif ()
  if (DEFINED GBA_MAKERCODE)
    list(APPEND GBAFIX_ARGS "-m${GBA_MAKERCODE}")
  endif ()
  if (DEFINED GBA_VERSION)
    list(APPEND GBAFIX_ARGS "-v${GBA_VERSION}")
  endif ()
  if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    list(APPEND GBAFIX_ARGS "-d1")
  endif ()

  add_custom_command(TARGET ${target} POST_BUILD
      COMMAND "${CMAKE_OBJCOPY}" -O binary "$<TARGET_FILE:${target}>" "${GBA_OUTPUT}"
      COMMAND "${GBA_GBAFIX_EXE}" "${GBA_OUTPUT}" ${GBAFIX_ARGS}
      BYPRODUCTS "${GBA_OUTPUT}"
      COMMENT "Building GBA ROM for ${target}"
      VERBATIM
  )
endfunction()
