INCLUDE(CMakeTestCompilerCommon)

# This file is used by EnableLanguage in cmGlobalGenerator to
# determine that that selected Go compiler can actually compile
# and link the most basic of programs. If not, a fatal error
# is set and cmake stops processing commands and will not generate
# any makefiles or projects.
IF(NOT CMAKE_GO_COMPILER_WORKS)
  PrintTestCompilerStatus("Go" "")
  FILE(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/cmTryCompileExec.go
    "package main\n"
    "import (\"fmt\")\n"
    "func main () {\n"
    "  fmt.Println(\"Hello World!\")\n"
    "  return\n"
    "}\n")
  TRY_COMPILE(CMAKE_GO_COMPILER_WORKS ${CMAKE_BINARY_DIR}
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/cmTryCompileExec.adb
    OUTPUT_VARIABLE __CMAKE_GO_COMPILER_OUTPUT)
  SET(Go_TEST_WAS_RUN 1)
ENDIF(NOT CMAKE_GO_COMPILER_WORKS)

IF(NOT CMAKE_GO_COMPILER_WORKS)
  PrintTestCompilerStatus("Go" " -- broken")
  FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
    "Determining if the Go compiler works failed with "
    "the following output:\n${__CMAKE_GO_COMPILER_OUTPUT}\n\n")
  MESSAGE(FATAL_ERROR "The Go compiler \"${CMAKE_GO_COMPILER}\" "
    "is not able to compile a simple test program.\nIt fails "
    "with the following output:\n ${__CMAKE_GO_COMPILER_OUTPUT}\n\n"
    "CMake will not be able to correctly generate this project.")
ELSE(NOT CMAKE_GO_COMPILER_WORKS)
  PrintTestCompilerStatus("Go" " -- works")
  FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
    "Determining if the Go compiler works passed with "
    "the following output:\n${__CMAKE_GO_COMPILER_OUTPUT}\n\n")
  SET(CMAKE_GO_COMPILER_WORKS 1 CACHE INTERNAL "")

  IF(CMAKE_GO_COMPILER_FORCED)
    # The compiler configuration was forced by the user.
    # Assume the user has configured all compiler information.
  ELSE(CMAKE_GO_COMPILER_FORCED)
    # Try to identify the ABI and configure it into CMakeGoCompiler.cmake
    INCLUDE(${CMAKE_ROOT}/Modules/CMakeDetermineCompilerABI.cmake)
    CMAKE_DETERMINE_COMPILER_ABI(Go ${CMAKE_MODULE_PATH}/CMakeGoCompilerABI.adb)
    CONFIGURE_FILE(
      ${CMAKE_MODULE_PATH}/CMakeGoCompiler.cmake.in
      ${CMAKE_PLATFORM_INFO_DIR}/CMakeGoCompiler.cmake
    )
    INCLUDE(${CMAKE_PLATFORM_INFO_DIR}/CMakeGoCompiler.cmake)
  ENDIF(CMAKE_GO_COMPILER_FORCED)
ENDIF(NOT CMAKE_GO_COMPILER_WORKS)

UNSET(__CMAKE_GO_COMPILER_OUTPUT)
