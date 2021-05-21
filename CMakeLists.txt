cmake_minimum_required(VERSION 3.10.0)
project(cluster VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(INSTALL_DIRECTORY "/opt/apps")

find_package(Qt5Core REQUIRED)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Gui REQUIRED)

include_directories(
    "${Qt5Core_INCLUDE_DIRS}"
    "${Qt5Qml_INCLUDE_DIRS}"
    "${Qt5Gui_INCLUDE_DIRS}"
)

set(SOURCES Application/main.cpp)

qt5_add_resources(
    RESOURCES
    GUIModel/GUIModel.qrc
    Assets/Common/3DModelData.qrc
    Assets/Common/3DModelTexture.qrc
    Assets/Common/Fonts.qrc
    Assets/Common/Images.qrc
    Assets/Common/Shaders.qrc
)

add_executable(
    ${PROJECT_NAME}
    ${SOURCES}
    ${RESOURCES}
)

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Qml Qt5::Gui)

if(NOT DEFINED APPS_INST_DIR)
    set(APPS_INST_DIR /opt/apps)
endif()

file(GLOB VIDEOS ${CMAKE_CURRENT_SOURCE_DIR}/Assets/Common/Videos/*)
install(FILES ${VIDEOS} DESTINATION ${APPS_INST_DIR})
install(TARGETS ${PROJECT_NAME} DESTINATION ${APPS_INST_DIR})

