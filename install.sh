#!/bin/bash

latest="v4.22-9634-beta-2016.11.27"
lateststable="v4.20-9608-rtm-2016.04.17"
installURL="http://www.softether-download.com/files/softether/"
installURLPath='-tree/Linux/SoftEther_VPN_Server/'

if [[ $EUID -ne 0 ]]; then
   echo "Please run me as a root/sudo'ed user, exiting." 
   exit 1
fi

echo "
####################################################
#	SoftEther Install Script
####################################################

	Heavily Modified By: Munzy
	Original Script By: AhmadShamli

####################################################
#	Select Architectures
####################################################

	1. Intel x64/AMD64 	(64bit)
	2. Intel x86 		(32bit)
	3. ARM EABI 		(32bit)

"

read -p "Please choose from the above options!" installArchINPUT </dev/tty

echo "
####################################################
#	Operating Systems
####################################################

	1. Debian/Ubuntu
	2. CentOS/Fedora
	
"

read -p "Please choose your current operating system!" installOSINPUT </dev/tty

echo "
####################################################
#	Build
####################################################

	1. Stable
	2. Newest (alpha, beta, release canidates)
	
"

read -p "Please choose the build type you would like!" installBuildINPUT </dev/tty

clear


if [[ ${installArchINPUT} == 1 ]]; then
	installArchLong="64bit_-_Intel_x64_or_AMD64"
	installArchShort="x64-64bit"	
elif [[ ${installArchINPUT} == 2 ]]; then
	installArchLong="32bit_-_Intel_x86"
	installArchShort="x86-32bit"
elif [[ ${installArchINPUT} == 3 ]]; then
	installArchLong="32bit_-_ARM_EABI"
	installArchShort="arm_eabi-32bit"
else
	echo "Architecture wasn't properly selected, exiting."
	exit 1
fi


if [[ ${installOSINPUT} == 1 ]]; then
	installOS='deb'
	apt-get update
	apt-get install build-essential -y
	apt-get install wget -y
elif [[ ${installOSINPUT} == 2 ]]; then
	installOS='cent'
	yum install gcc make -y
    yum install wget -y
else
	echo "OS wasn't properly selected, exiting."
	exit 1
fi


if [[ ${installBuildINPUT} == 1 ]]; then
	installBuild=${lateststable}
elif [[ ${installBuildINPUT} == 2 ]]; then
	installBuild=${latest}
else
	echo "Build wasn't properly selected, exiting."
	exit 1
fi


installFile="softether-vpnserver-${installBuild}-linux-${installArchShort}.tar.gz"
installURLFull=${installURL}${installBuild}${installURLPath}${installArchLong}/${installFile}

echo "Changing to /tmp to download files."
cd /tmp/


wget --content-disposition "${installURLFull}"

if [ -f ${installFile} ];then
	tar xzf ${installFile}
	cd vpnserver
else
	echo "OOOPS! We didn't download the file, or can't find it, exiting."
	exit 1
fi

	
make </dev/tty
cd ..
mv vpnserver /usr/local
cd /usr/local/vpnserver/

chmod 600 *
chmod 700 vpnserver
chmod 700 vpncmd

mkdir /var/lock/subsys

echo "#!/bin/sh
# chkconfig: 2345 99 01
# description: SoftEther VPN Server
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x \$DAEMON || exit 0
case \"\$1\" in
start)
\$DAEMON start
touch \$LOCK
;;
stop)
\$DAEMON stop
rm \$LOCK
;;
restart)
\$DAEMON stop
sleep 3
\$DAEMON start
;;
*)
echo \"Usage: \$0 {start|stop|restart}\"
exit 1
esac
exit 0
" > /etc/init.d/vpnserver

chmod 755 /etc/init.d/vpnserver
if [[ ${installOS} == "cent" ]];then
	chkconfig --add vpnserver
	/etc/init.d/vpnserver start
elif [ ${installOS} == "deb" ];then
	update-rc.d vpnserver defaults
	/etc/init.d/vpnserver start
fi

rm /tmp/${installFile}


echo "
####################################################
#	Install Complete!
####################################################

	1. Please launch /usr/local/vpnserver/vpncmd in terminal.
	2. Press 1 and fill the rest of the requested fields with nothing.
	3. Type ServerPasswordSet in the console, and set your password.
	4. Once you finished setting the password, logout of the console with quit.
	5. The service name is vpnserver. Alas server vpnserver restart.
	6. Launch SE-VPN Server Manager on your desktop and configure your se server.
	
	Donations appreciated: 
	https://www.cameronmunroe.com/coffee/

"	


