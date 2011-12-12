ORIGIN="http://download.zeromq.org/zeromq-2.1.10.tar.gz"
MD5=f034096095fa76041166a8861e9d71b7

BUILD_STEPS=( 
    "rm -rf source root && mkdir -p source "
    "tar -xzvf ${CACHE_DIR}/${MD5} -C source"
    "cd source/zeromq-2.1.10"
    "./configure --prefix=${destination}" 
    "make" 
    "make install" 
)

SPOT_CHECKS=(
    "test -d root/lib"
)

debug "calling get for zeromq source"
get  -o $ORIGIN  -m $MD5

debug "calling build for zeromq source"
build -s BUILD_STEPS[@] -c SPOT_CHECKS[@] -m $MD5
