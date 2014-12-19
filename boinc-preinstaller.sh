#!/bin/bash
if [ $USER != root ]; then
echo "Error: debes ser root"
exit 1
fi
trap "rm -f /run/boinc-preinstaller.pid; exit" INT TERM EXIT
echo $BASHPID > /run/boinc-preinstaller.pid
tipo=$(arch)
quien=$(who | cut -d' ' -f1 | sort | uniq)	
apt -y install libxss1 libwxgtk2.8-0 freeglut3 xscreensaver libjpeg62
if [[ $tipo = x86_64 ]];then
	apt -y install libstdc++5 libstdc++6 ia32-libs-i386
fi
ln -sv /home/$quien/Descargas/BOINC/ /var/lib/boinc/
ln -sv /home/$quien/Descargas/BOINC/boincscr /usr/lib/xscreensaver/boincscr
ln -sv /usr/lib/i386-linux-gnu/libssl.so.1.0.0 /usr/lib/i386-linux-gnu/libssl.so.8
ln -sv /usr/lib/i386-linux-gnu/libcrypto.so.1.0.0 /usr/lib/i386-linux-gnu/libcrypto.so.8





echo '- GL: /home/$quien/Descargas/BOINC/boincscr -root -boinc_dir /home/$quien/Descargas/BOINC/ \n\'

echo "Instalacion de dependencias de BOINC completada..."
rm -f /run/boinc-preinstaller.pid
trap - INT TERM EXIT
exit 0
