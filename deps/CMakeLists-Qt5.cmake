include(ExternalProject)

#===== QT =====#
set(QT_VERSION 5.9.1)
set(QT_VERSION_MAJ 5.9)
set(QT "${EXTERNAL_PROJECT_DIR}/qt5-${QT_VERSION}")

find_path(QT_IN_DEPS NAMES lib/libQt5Bootstrap.a PATHS ${QT}/)
if(QT_IN_DEPS)

else()
    ExternalProject_Add(
        QT_project
        DOWNLOAD_DIR ${QT}
        URL https://download.qt.io/official_releases/qt/${QT_VERSION_MAJ}/${QT_VERSION}/single/qt-everywhere-opensource-src-${QT_VERSION}.tar.xz
        SOURCE_DIR "${QT}"
        BUILD_IN_SOURCE 1
        UPDATE_COMMAND ""
        CONFIGURE_COMMAND ./configure -prefix ${QT} -opensource;-confirm-license;-release
        BUILD_COMMAND make
        INSTALL_COMMAND make install
    )
endif()

#add_library(libQt5Core STATIC IMPORTED)
#set_property(TARGET libQt5Core PROPERTY IMPORTED_LOCATION ${QT}/lib/libQt5Core.a)
#add_dependencies(libQt5Core QT_project)
#list(APPEND ExternalSharedLibraries ${QT}/lib/libQt5Core.a)
#list(APPEND RPATH_IMPORTED "${QT};")

set(CMAKE_PREFIX_PATH "${QT}/lib/cmake")
find_package(Qt5Widgets REQUIRED)
find_package(Qt5QML REQUIRED)
find_package(Qt5Core REQUIRED)
find_package(Qt5Quick REQUIRED)

#include_directories(${QT}/include)
