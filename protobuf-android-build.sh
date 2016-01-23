#!/bin/bash 

CURRENT=`pwd`
PREFIX=`pwd`/protobuf


NDKROOT=/home/data/android/android-ndk-r10e
TOOLCHAIN=arm-linux-androideabi-4.9
PREBUILT=$NDKROOT/toolchains/$TOOLCHAIN
PLATFORM=$NDKROOT/platforms/android-8/arch-arm

GNUSTD=$NDKROOT/sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi-v7a

PROTOCEXE=/usr/bin/protoc

export CC="$PREBUILT/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc --sysroot=$PLATFORM"
export CXX="$PREBUILT/prebuilt/linux-x86_64/bin/arm-linux-androideabi-g++ --sysroot=$PLATFORM"

export PATH=$PREBUILT/prebuilt/linux-x86_64/arm-linux-androideabi/bin:$PATH
export CFLAGS=" -DANDROID -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16"
export LDFLAGS="-Wl,-rpath-link=$PLATFORM/usr/lib -L$GNUSTD -L$PLATFORM/usr/lib"
export CPPFLAGS="-I$PLATFORM/usr/include/ -I$GNUSTD/include -I$NDKROOT/sources/cxx-stl/gnu-libstdc++/4.9/include"

export LIBS="-lc -lgnustl_static"

(
	cd /tmp
	wget https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz
	if [ -d /tmp/protobuf-2.6.1 ]
    	then
		rm -rf /tmp/protobuf-2.6.1
	fi
	tar -xvf protobuf-2.6.1.tar.gz
)

cd /tmp/protobuf-2.6.1

mkdir build

./configure  --prefix=$(pwd)/build			\
			--host=arm-linux-androideabi 	\
			--with-sysroot=$SYSROOT 		\
			--disable-shared 			\
			--enable-cross-compile 		\
			--with-protoc=$PROTOCEXE

make && make install

$PREBUILT/prebuilt/linux-x86_64/bin/arm-linux-androideabi-readelf -A build/lib/libprotobuf-lite.a

cp build/lib/libprotobuf.a $PREFIX/libprotobuf.a
cp build/lib/libprotobuf-lite.a $PREFIX/libprotobuf-lite.a

cd $CURRENT

