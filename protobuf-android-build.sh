#!/bin/bash 

CURRENT=`pwd`
PREFIX=`pwd`/protobuf
PROTOBUFVER=2.6.1

NDKROOT=/home/data/android/android-ndk-r10e
TOOLCHAIN=arm-linux-androideabi-4.9
PREBUILT=$NDKROOT/toolchains/$TOOLCHAIN
SYSROOT=$NDKROOT/platforms/android-8/arch-arm

GNUSTD=$NDKROOT/sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi-v7a

PROTOCEXE=/usr/bin/protoc

export CC="$PREBUILT/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc --sysroot=$SYSROOT"
export CXX="$PREBUILT/prebuilt/linux-x86_64/bin/arm-linux-androideabi-g++ --sysroot=$SYSROOT"

export PATH=$PREBUILT/prebuilt/linux-x86_64/arm-linux-androideabi/bin:$PATH
export CFLAGS=" -DANDROID -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16"
export LDFLAGS="-Wl,-rpath-link=$SYSROOT/usr/lib -L$GNUSTD -L$SYSROOT/usr/lib"
export CPPFLAGS="-I$SYSROOT/usr/include/ -I$GNUSTD/include -I$NDKROOT/sources/cxx-stl/gnu-libstdc++/4.9/include"

export LIBS="-lc -lgnustl_static"

(
	cd /tmp
	wget https://github.com/google/protobuf/releases/download/v$PROTOBUFVER/protobuf-$PROTOBUFVER.tar.gz
	if [ -d /tmp/protobuf-$PROTOBUFVER ]
    	then
		rm -rf /tmp/protobuf-$PROTOBUFVER
	fi
	tar -xvf protobuf-$PROTOBUFVER.tar.gz
)

cd /tmp/protobuf-$PROTOBUFVER

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

