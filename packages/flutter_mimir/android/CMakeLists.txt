set(MimirVersion "mimir-v0.0.1") # generated; do not edit

# Unlike the Windows & Linux CMakeLists.txt, this Android equivalent is just here
# to download the Android binaries into src/main/jniLibs/ and does not build anything.
# The binary download/extraction is difficult to do concisely in Groovy/Gradle,
# at least across host platforms, so we are just reusing our Linux/Windows logic.

# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

# Download the binaries if they are not already present.
set(MimirLibRoot "${CMAKE_CURRENT_SOURCE_DIR}/src/main/jniLibs")
set(MimirArchivePath "${CMAKE_CURRENT_SOURCE_DIR}/${MimirVersion}.tar.gz")
if(NOT EXISTS ${MimirArchivePath})
  file(DOWNLOAD
    "https://github.com/GregoryConrad/mimir/releases/download/${MimirVersion}/EmbeddedMilliAndroid.tar.gz"
    ${MimirArchivePath}
    TLS_VERIFY ON
  )
endif()

# Extract the binaries, overriding any already present.
file(REMOVE_RECURSE ${MimirLibRoot})
file(MAKE_DIRECTORY ${MimirLibRoot})
execute_process(
  COMMAND ${CMAKE_COMMAND} -E tar xzf ${MimirArchivePath}
  WORKING_DIRECTORY ${MimirLibRoot}
)
