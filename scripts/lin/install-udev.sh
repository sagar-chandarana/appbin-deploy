set -e

udiskbin=`which udisks`

udevso=`ldd $udiskbin | grep libudev.so | awk '{print $3;}'`

if [ -e "$udevso" ]; then

   ln -sf "$udevso" ./libudev.so.0

fi