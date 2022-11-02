# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(embedded_meilisearch_library VERSION 0.0.1 LANGUAGES C)

add_library(embedded_meilisearch SHARED
  "embedded_meilisearch.c"
)

set_target_properties(embedded_meilisearch PROPERTIES
  PUBLIC_HEADER embedded_meilisearch.h
  OUTPUT_NAME "embedded_meilisearch"
)

target_compile_definitions(embedded_meilisearch PUBLIC DART_SHARED_LIB)
