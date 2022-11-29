set(MimirVersion "mimir-v0.0.0-dev.5") # generated; do not edit

# TODO Remove this workaround once Flutter supports Windows ARM.
# https://github.com/flutter/flutter/issues/116196
set(FLUTTER_TARGET_PLATFORM windows-x64)

# The Flutter tooling requires that developers have a version of Visual Studio
# installed that includes CMake 3.14 or later. You should not increase this
# version, as doing so will cause the plugin to fail to compile for some
# customers of the plugin.
cmake_minimum_required(VERSION 3.14)

# Project-level configuration.
set(PROJECT_NAME "flutter_mimir")
project(${PROJECT_NAME} LANGUAGES CXX)

# Download the binaries if they are not already present.
set(MimirLibRoot "${CMAKE_CURRENT_SOURCE_DIR}/${MimirVersion}")
set(MimirArchivePath "${MimirLibRoot}.tar.gz")
if(NOT IS_DIRECTORY ${MimirLibRoot})
  file(MAKE_DIRECTORY ${MimirLibRoot})
  file(DOWNLOAD
    "https://github.com/GregoryConrad/mimir/releases/download/${MimirVersion}/EmbeddedMilli.tar.gz"
    ${MimirArchivePath}
    TLS_VERIFY ON
  )
  execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar xzf ${MimirArchivePath}
    WORKING_DIRECTORY ${MimirLibRoot}
  )
endif()

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(flutter_mimir_bundled_libraries
  "${MimirLibRoot}/${FLUTTER_TARGET_PLATFORM}/embedded_milli.dll"
  PARENT_SCOPE
)
