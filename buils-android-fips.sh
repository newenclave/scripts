$ANDROID_NDK_HOME is my android-ndk folder
export ANDROID_NDK=$ANDROID_NDK_HOME
export FIPS_SIG=$PWD/util/incore
export PATH="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin":$PATH
export MACHINE=armv7l
export RELEASE=2.6.32.GMU
export SYSTEM=android
export ARCH=arm
export CROSS_COMPILE="arm-linux-androideabi-"
export ANDROID_DEV="$ANDROID_NDK/platforms/android-14/arch-arm/usr" 
export HOSTCC=gcc

#https://wiki.openssl.org/index.php/FIPS_Library_and_Android
#https://wiki.openssl.org/index.php/Android
