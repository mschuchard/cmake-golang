cmake_minimum_required(VERSION 3.5)

project(GOTEST)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../module")
enable_language(GO)

add_executable(main main.go)
