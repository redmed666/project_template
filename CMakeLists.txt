# CMAKE + project name
cmake_minimum_required(VERSION 2.8.12)
project(MyApp)

#set some variables
enable_testing()
set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_AUTORCC ON)
set(QT_USE_QTGUI TRUE)
set(QT_USE_QTXML TRUE)
set(EXTERNAL_PROJECT_DIR "$ENV{HOME}/Documents/Codes/3rdparty")

#find packages
find_package(Doxygen)

#Doxygen things
if(DOXYGEN_FOUND)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
add_custom_target(doc
  ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Generating API documentation with Doxygen" VERBATIM
)
endif(DOXYGEN_FOUND)

#Recursively look for the src files
file(GLOB_RECURSE MyApp_SOURCES "src/*.cpp")
file(GLOB_RECURSE MyApp_HEADERS "src/*.hpp")
set (MyApp_INCLUDE_DIRS "")
foreach (_headerFile ${MyApp_HEADERS})
    get_filename_component(_dir ${_headerFile} PATH)
    list (APPEND MyApp_INCLUDE_DIRS ${_dir})
endforeach()
#list(APPEND MyApp_SOURCES src/resources.qrc)
list(REMOVE_DUPLICATES MyApp_INCLUDE_DIRS)

file(GLOB_RECURSE untittest_myapp_SOURCES "test/*.cpp")

#compilation + linkage
add_executable (MyApp ${MyApp_SOURCES})
target_compile_features(MyApp PRIVATE cxx_range_for)

#external dep
include(deps/CMakeLists-Gtest.cmake)
include(deps/CMakeLists-Qt5.cmake)

#include some directories
include_directories("./src")
include_directories(${MyApp_INCLUDE_DIRS})

#linkage
target_link_libraries(MyApp Qt5::Widgets Qt5::Qml Qt5::Quick)

#Test folder
add_executable (untittest_myapp ${untittest_myapp_SOURCES})
target_link_libraries(untittest_myapp gtest)
add_test (UnitTest bin/untittest_myapp)
