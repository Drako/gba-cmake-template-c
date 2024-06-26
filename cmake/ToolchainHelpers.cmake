cmake_minimum_required(VERSION 3.25.0)
cmake_policy(PUSH)
cmake_policy(VERSION 3.25.0)
include_guard(GLOBAL)

function(find_devkitpro)
  find_path(
      DEVKITPRO
      NAMES devkitARM/gba_rules
      REGISTRY_VIEW BOTH
      REQUIRED
      NO_DEFAULT_PATH
      PATHS
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\devkitProUpdater;InstallLocation]"
      ENV DEVKITPRO
      /opt/devkitpro
  )

  cmake_path(APPEND DEVKITPRO devkitARM OUTPUT_VARIABLE DEVKITARM)
  message(STATUS "Found devkitARM: ${DEVKITARM}")
  return(PROPAGATE DEVKITPRO DEVKITARM)
endfunction()

cmake_policy(POP)
