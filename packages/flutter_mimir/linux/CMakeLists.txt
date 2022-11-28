# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

# Project-level configuration.
set(PROJECT_NAME "flutter_mimir")
project(${PROJECT_NAME} LANGUAGES CXX)

# TODO check for ${CMAKE_CURRENT_SOURCE_DIR}/${MIMIR_VERSION} existing already
# if does not exist:
# - download this version's linux build zip to ${CMAKE_CURRENT_SOURCE_DIR}/${MIMIR_VERSION}

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(flutter_mimir_bundled_libraries
  "${CMAKE_CURRENT_SOURCE_DIR}/${MIMIR_VERSION}/${FLUTTER_TARGET_PLATFORM}/libembedded_milli.so"
  PARENT_SCOPE
)
