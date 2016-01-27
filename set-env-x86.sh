#!/bin/bash 

CURRENT=`pwd`
PREFIX=`pwd`/protobuf

if ! [ $ANDROID_NDK_ROOT ] ; then 
	ANDROID_NDK_ROOT=/home/data/android/android-ndk-r10e
fi

NDKROOT=$ANDROID_NDK_ROOT

GCCVER=4.9
ARCHNAME=i686-linux-android
ABIVER=x86
TOOLCHAIN=x86-$GCCVER
PREBUILDNAME=linux-x86_64

PLATFORM=android-9
PLATFORMARCH=arch-x86

STLVER=gnu-libstdc++
STLLIB=gnustl_static

PREBUILT=$NDKROOT/toolchains/$TOOLCHAIN/prebuilt/$PREBUILDNAME
SYSROOT=$NDKROOT/platforms/$PLATFORM/$PLATFORMARCH

GNUSTD=$NDKROOT/sources/cxx-stl/$STLVER/$GCCVER/libs/$ABIVER

PATH_CC=`ls $PREBUILT/bin | grep \\\-gcc$`
PATH_CXX=`ls $PREBUILT/bin | grep \\\-g++$`
#PATH_LD=`ls $PREBUILT/bin | grep \\\-ld$`

export CC="$PREBUILT/bin/$PATH_CC --sysroot=$SYSROOT"
export CXX="$PREBUILT/bin/$PATH_CXX --sysroot=$SYSROOT"
#export LD="$PREBUILT/bin/$PATH_LD --sysroot=$SYSROOT"

export PATH=$PREBUILT/$ARCHNAME/bin:$PATH
export CFLAGS=" "
export LDFLAGS="-Wl,-rpath-link=$SYSROOT/usr/lib -L$GNUSTD -L$SYSROOT/usr/lib"
export CPPFLAGS="-I$SYSROOT/usr/include/ -I$GNUSTD/include -I$NDKROOT/sources/cxx-stl/$STLVER/$GCCVER/include"

export LIBS="-lc -l$STLLIB"

echo $CFLAGS

