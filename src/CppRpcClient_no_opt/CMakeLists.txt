cmake_minimum_required(VERSION 3.5)
PROJECT(CLIENTDEMO)

SET(SRC_LIST client_demo.cpp)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

set(INCLUDE_PATH ${WORKSPACE}/tugraph-db/include)
set(LABRARY_PATH ${WORKSPACE}/tugraph-db/build/output)


INCLUDE_DIRECTORIES(${INCLUDE_PATH})
LINK_DIRECTORIES(${LABRARY_PATH})

ADD_EXECUTABLE(clientdemo ${SRC_LIST})

TARGET_LINK_LIBRARIES(clientdemo lgraph_client_cpp_rpc)
