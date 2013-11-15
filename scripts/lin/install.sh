echo Moving files..
mkdir -p /$HOME/.appbin
mv appbin /$HOME/.appbin

echo Linking required libs..
set -e
udiskbin=`which udisks`
udevso=`ldd $udiskbin | grep libudev.so | awk '{print $3;}'`
if [ -e "$udevso" ]; then
   ln -sf "$udevso" /$HOME/.appbin/program_files/libudev.so.0
fi

echo Creating Shortcuts..
cat > ./appbin-sc.desktop << EOF
[Desktop Entry]
Name=Appbin
Icon=/$HOME/.appbin/program_files/appbin.png
Exec=/$HOME/.appbin/program_files/appbin
Path=/$HOME/.appbin/program_files
GenericName=Appbin - Sync Applications Seamlessly
Type=Application
EOF

cat > ./appbin-dir.directory << EOF
[Desktop Entry]
Version=1.0
Name=Appbin
Icon=/$HOME/.appbin/program_files/appbin.png
Type=Directory
EOF

xdg-desktop-menu install appbin-dir.directory appbin-sc.desktop
xdg-desktop-icon install appbin-sc.desktop
rm appbin-dir.directory
rm appbin-sc.desktop

echo Setting permissions..
chmod +x -f /$HOME/.appbin/program_files/appbin
chmod +x -f /$HOME/.appbin/program_files/appbin_nw
chmod +x -f /$HOME/.appbin/program_files/nw
chmod +x -f /$HOME/.appbin/program_files/appbin_daemon
#chmod +x -f /$HOME/.appbin/program_files/bin/appbin_7za
#chmod +x -f /$HOME/.appbin/program_files/uninstall

echo Starting Appbin..
cd /$HOME/.appbin/program_files
./appbin_daemon &
./appbin &