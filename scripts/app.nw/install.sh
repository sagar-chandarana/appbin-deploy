#!/bin/bash
#SCRIPT_PATH="${BASH_SOURCE[0]}";

#if ([ -h "${SCRIPT_PATH}" ]) then
#  while([ -h "${SCRIPT_PATH}" ]) do SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
#fi
#pushd . > /dev/null
#cd `dirname ${SCRIPT_PATH}` > /dev/null
#SCRIPT_PATH=`pwd`;
#echo "SCRIPT_PATH "$SCRIPT_PATH;


if [ "$(uname)" == "Darwin" ]; then
    sys="Mac"     
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sys="Lin"
fi

echo `pwd`

echo Killing appbin processes..
if [ $sys = "Mac"  ]; then
	killall -9 appbin_daemon_mac
	killall -9 appbin_7z
	killall -9 appbin_nw_mac
elif [ $sys = "Lin"  ]; then
	killall -s 9 appbin_daemon_lin
	killall -s 9 appbin_7z
	killall -s 9 appbin_nw_lin
fi
echo "Finished killing existing processes.";

echo Moving files..
if [ $sys = "Mac"  ]; then
	binZip=binMac
	daemonZip=daemonMac
elif [ $sys = "Lin"  ]; then
	binZip=binLin
	daemonZip=daemonLin
	
fi
mv $HOME/.appbin/program_files/apps $HOME/.appbin/apps
rm -rf $HOME/.appbin/program_files 2>/dev/null
mkdir -p $HOME/.appbin/program_files 2>/dev/null
unzip -q ./../$binZip.zip -d $HOME/.appbin/program_files/
unzip -q ./../$daemonZip.zip -d $HOME/.appbin/program_files/
unzip -q ./../appbinNw.zip -d $HOME/.appbin/program_files/
mv $HOME/.appbin/apps  $HOME/.appbin/program_files/apps 2>/dev/null
echo Files moved.


if [ $sys = "Lin"  ]; then
	echo Linking required libs..
	set -e
	udiskbin=`which udisks`
	udevso=`ldd $udiskbin | grep libudev.so | awk '{print $3;}'`
	if [ -e "$udevso" ]; then
	   ln -sf "$udevso" $HOME/.appbin/program_files/libudev.so.0
	fi

fi


echo Creating Shortcuts..

if [ $sys = "Mac"  ]; then
	ln -sf $HOME/.appbin/program_files/Appbin.app $HOME/Desktop
elif [ $sys = "Lin"  ]; then

cat > $HOME/.appbin/appbin-sc.desktop << EOF
[Desktop Entry]
Name=Appbin
Icon=$HOME/.appbin/program_files/appbin.png
Exec=$HOME/.appbin/program_files/appbin
Path=$HOME/.appbin/program_files
GenericName=Appbin - Sync Applications Seamlessly
Type=Application
EOF

cat > $HOME/.appbin/appbin-dir.directory << EOF
[Desktop Entry]
Version=1.0
Name=Appbin
Icon=$HOME/.appbin/program_files/appbin.png
Type=Directory
EOF

xdg-desktop-menu install $HOME/.appbin/appbin-dir.directory $HOME/.appbin/appbin-sc.desktop
xdg-desktop-icon install $HOME/.appbin/appbin-sc.desktop
rm -f $HOME/.appbin/appbin-dir.directory
rm -f $HOME/.appbin/appbin-sc.desktop

fi

echo Setting permissions..
chmod -f +x $HOME/.appbin/program_files/appbin
chmod -f +x $HOME/.appbin/program_files/appbin_nw
chmod -f +x $HOME/.appbin/program_files/nw.app
chmod -f +x $HOME/.appbin/program_files/appbin_daemon
chmod -f +x $HOME/.appbin/program_files/bin/appbin_7za

echo "Done."
