#!/bin/sh

app=("httpd" "mysql-server" "php php-fpm php-mysqlnd php-opcache php-gd php-xml php-mbstring" "apache2" "mysql-server mysql-client libmysqlclient-dev" "php7.2 libapache2-mod-php7.2 php-mysql	")

appName=("httpd" "mysql" "php" "apache2" "mysql-server" "libapache2-mod-php7.2")

if [[ -f "/etc/debian_version" ]]
then
    command="apt"
    start=3
else
    command="dnf"
    start=0
fi

for (( i=${start};i<${start}+3;i++ ));
do

if ([ $start -eq 0 ] && !( rpm -qa | grep -q ${appName[$i]} )) || ([ $start -eq 3 ]  && [ $(dpkg-query -W -f='${Status}' ${appName[$i]} 2>/dev/null | grep -c "ok installed") -eq 0 ]) ;

then

        $command install -y ${app[$i]}
else

        echo "${appName[$i]} already installed"  
fi
done
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~                                                                                                                                                                       
~               
