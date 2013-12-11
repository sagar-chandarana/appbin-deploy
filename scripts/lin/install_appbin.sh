echo Linking required libs..
set -e
udiskbin=`which udisks`
udevso=`ldd $udiskbin | grep libudev.so | awk '{print $3;}'`
if [ -e "$udevso" ]; then
   ln -sf "$udevso" ./libudev.so.0
fi

LD_LIBRARY_PATH=./:$LD_LIBRARY_PATH ./files/nw ./files/app.nw &
