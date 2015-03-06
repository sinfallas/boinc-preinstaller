#!/bin/bash
if [[ $USER != root ]]; then
echo -e "\e[00;31mERROR: must be root\e[00m"
exit 1
fi
trap "rm -f /run/boinc-preinstaller.pid; exit" INT TERM EXIT
echo $BASHPID > /run/boinc-preinstaller.pid
tipo=$(arch)
quien=$(who | cut -d' ' -f1 | sort | uniq)
apt update
apt -y install libxss1 libwxgtk2.8-0 freeglut3 xscreensaver libjpeg62
if [[ $tipo = x86_64 ]];then
	apt -y install libstdc++5 libstdc++6 ia32-libs-i386
fi
mkdir -p /home/$quien/BOINC
ln -sv /home/$quien/BOINC/ /var/lib/boinc/
ln -sv /home/$quien/BOINC/boincscr /usr/lib/xscreensaver/boincscr
ln -sv /usr/lib/i386-linux-gnu/libssl.so.1.0.0 /usr/lib/i386-linux-gnu/libssl.so.8
ln -sv /usr/lib/i386-linux-gnu/libcrypto.so.1.0.0 /usr/lib/i386-linux-gnu/libcrypto.so.8
# echo '- GL: /home/$quien/BOINC/boincscr -root -boinc_dir /home/$quien/BOINC/ \n\' >> /home/$quien/.xscreensaver
echo "<cc_config>" > /home/$quien/BOINC/cc_config.xml
echo "  <options>" >> /home/$quien/BOINC/cc_config.xml
echo "    <http_1_0>1</http_1_0>" >> /home/$quien/BOINC/cc_config.xml
echo "  </options>" >> /home/$quien/BOINC/cc_config.xml
echo "</cc_config>" >> /home/$quien/BOINC/cc_config.xml
chown -R $quien /home/$quien/BOINC
echo "Download BOINC installer and copy to /home/"$quien" and run." 
rm -f /run/boinc-preinstaller.pid
trap - INT TERM EXIT
echo -e "\e[00;1;92mFinished...\e[00m"
exit 0
