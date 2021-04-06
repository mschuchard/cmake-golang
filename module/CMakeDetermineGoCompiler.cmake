# determine the compiler to use for Go programs
#
# Sets the following variables:
#   CMAKE_GO_COMPILER
#   CMAKE_COMPILER_IS_GNUGo
#   CMAKE_GO_LINKER

IF(NOT CMAKE_GO_COMPILER)
  find_program(CMAKE_GO_COMPILER
    NAMES go go.exe
    PATHS $ENV{GOPATH}
    $ENV{GO}
    $ENV{GOROOT}
    /usr/bin
    /usr/local/bin
  )
  MESSAGE("Go Compiler at ${CMAKE_GO_COMPILER} used for compilation.")
ENDIF(NOT CMAKE_GO_COMPILER)
MARK_AS_ADVANCED(CMAKE_GO_COMPILER)

IF(NOT CMAKE_GO_COMPILER_ID_RUN)
  SET(CMAKE_GO_COMPILER_ID_RUN 1)
  SET(CMAKE_COMPILER_IS_GNUGo 1)
  SET(CMAKE_GO_COMPILER_ID "GNU")
  #TODO
  SET(CMAKE_GO_PLATFORM_ID "Linux")
ENDIF(NOT CMAKE_GO_COMPILER_ID_RUN)

IF(NOT CMAKE_GO_LINKER)
  find_program(CMAKE_GO_LINKER
    NAMES go go.exe
    PATHS $ENV{GOPATH}
    $ENV{GO}
    $ENV{GOROOT}
    /usr/bin
    /usr/local/bin
  )
  MESSAGE("Go Linker at ${CMAKE_GO_LINKER} used for linking.")
ENDIF(NOT CMAKE_GO_LINKER)
MARK_AS_ADVANCED(CMAKE_GO_LINKER)

#reset to defaults if otherwise established
IF(NOT CMAKE_GO_LINKER_ID_RUN)
  SET(CMAKE_GO_LINKER_ID_RUN 1)
  #TODO
  SET(CMAKE_LINKER_IS_Linux 1)
  SET(CMAKE_LINKER_IS_GNUGo 1)
ENDIF(NOT CMAKE_GO_COMPILER_ID_RUN)

INCLUDE(CMakeFindBinUtils)
# configure all variables set in this file
CONFIGURE_FILE(${CMAKE_MODULE_PATH}/CMakeGoCompiler.cmake.in ${CMAKE_PLATFORM_INFO_DIR}/CMakeGoCompiler.cmake @ONLY)

SET(CMAKE_GO_COMPILER_ENV_VAR "GO")
