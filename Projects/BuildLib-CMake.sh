#!/bin/bash

#REM   ******************* README *********************************
#REM    You might have to adjust some settings manually. This file
#REM    requires that you know the name of your CMake generator, if
#REM    you have more than one development environment installed.
#REM   ******************* README *********************************

#if [ "$(uname)" == "Darwin" ]; then
#    echo "Mac OS X is untested..."
#    CMake_generator="Unix Makefiles"
#    exit 1
#elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
#    CMake_generator="Unix Makefiles"
#elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
#    CMake_generator="MinGW Makefiles"
#fi
NCPU=`nproc --all`
CMAKE_SYSTEM_NAME='linux64'
EXTERNALS="../externals"
if [ ! -d "$EXTERNALS" ]; then mkdir -p "$EXTERNALS"; fi
EXTERNALS=`readlink -f "$EXTERNALS"`
CP_SRC="${EXTERNALS}/CoolProp.git"

BUILD_DIR="build"
if [ ! -d "$BUILD_DIR" ]; then mkdir -p "$BUILD_DIR"; fi
BUILD_DIR=`readlink -f "$BUILD_DIR"`

echo " "
echo "********* Detecting supported property libraries ***********"
FLUIDP=0
COOLP=1
echo "FluidProp support set to: $FLUIDP"
echo  "CoolProp support set to: $COOLP"

if [ "$COOLP" == "1" ]; then
  echo "******************** CoolProp ******************************"
  echo "Sources are located in $CP_SRC"
  if [ -d "$CP_SRC" ]; then
    pushd "$CP_SRC"
    git pull origin master
    git checkout v6.1.0
    git submodule init
    git submodule update
    # git submodule foreach git pull origin master
    popd
  else
    git clone https://github.com/fmtlib/fmt.git
    cd fmt
      cmake CMakeLists.txt
      make
      make install
    cd ..
    git clone --recursive https://github.com/BENGAL-TIGER/CoolPropMDA.git "$CP_SRC"
      git submodule add https://github.com/catchorg/Catch2 "$CP_SRC/externals/Catch"
      git submodule add https://github.com/eigenteam/eigen-git-mirror.git "$CP_SRC/externals/Eigen"
      git submodule add https://github.com/CoolProp/ExcelAddinInstaller.git "$CP_SRC/externals/ExcelAddinInstaller"
      git submodule add https://github.com/sakra/FindMathematica "$CP_SRC/externals/FindMathematica"
      git submodule add https://github.com/CoolProp/IF97 "$CP_SRC/externals/IF97"
      git submodule add https://github.com/CoolProp/REFPROP-headers.git "$CP_SRC/externals/REFPROP-headers"
      git submodule add https://github.com/fmtlib/fmt.git "$CP_SRC/externals/fmtlib"
      git submodule add https://github.com/msgpack/msgpack-c "$CP_SRC/externals/msgpack-c"
      git submodule add https://github.com/pybind/pybind11.git "$CP_SRC/externals/pybind11"
      git submodule add https://github.com/Tencent/rapidjson.git "$CP_SRC/externals/rapidjson"
    # git pull origin master
    # git submodule init
    # git submodule update
    # {mda) git clone -b goodExternals --single-branch --recursive https://github.com/BENGAL-TIGER/CoolProp.git "$CP_SRC"
    # (slamer59) git clone -b v6.1.0 --single-branch --recursive https://github.com/CoolProp/CoolProp.git "$CP_SRC"
    # git clone --recursive https://github.com/CoolProp/CoolProp.git "$CP_SRC"
  fi
fi
pushd "$BUILD_DIR"
# cmake .. -G "%CMake_generator%"
cmake ..
cmake --build . --config Release --target install -- -j$NCPU
popd

exit 0
