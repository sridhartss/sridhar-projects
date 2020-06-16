#!/bin/sh
#!/bin/sh
mysql -uroot -psridhar -h first_mysqlService -e "GRANT ALL PRIVILEGES ON *.* TO 'sridhar'@'%';";
mysql -uroot -psridhar -h first_mysqlService -e "GRANT ALL PRIVILEGES ON *.* TO 'sridhar'@'%';";
#Creating database if not exists
if ! mysql -usridhar -psridhar -h first_mysqlService -e 'use geoLocation';
then
   mysql -usridhar -psridhar -h first_mysqlService -e "create database geoLocation";
   echo "CREATING DATABASE..."
else
   echo "DATABASE ALREADY EXISTS..."
fi

#Creating table if not exist
mysql -usridhar -psridhar -h first_mysqlService -D geoLocation -e "create table if not exists geoLocation(ip varchar(20),type varchar(20),continent_name varchar(20),country_name varchar(20),region_name varchar(20),city varchar(20),capital varchar(20),language1 varchar(20),language2 varchar(20));";
mysql -usridhar -psridhar -h first_mysqlService -D geoLocation -e "create table if not exists geoLocation(ip varchar(20),type varchar(20),continent_name varchar(20),country_name varchar(20),region_name varchar(20),city varchar(20),capital varchar(20),language1 varchar(20),language2 varchar(20));";

#Fetching geodetails from the api and inserting into the table
echo "FETCHING DATA FROM API..."
result=$(curl http://api.ipstack.com/157.51.92.32?access_key=0412ebf8de9ed4e128470d28703cc8bb)
if [ $? -eq 0 ]
then
   mysql -usridhar -psridhar -h first_mysqlService -D geoLocation -e "INSERT INTO geoLocation (ip,type,continent_name,country_name,region_name,city,capital,language1,language2) VALUES ('$(echo ${result} | jq -r '.ip')','$(echo ${result} | jq -r '.type')','$(echo ${result} | jq -r '.continent_name')','$(echo ${result} | jq -r '.country_name')','$(echo ${result} | jq -r '.region_name')','$(echo ${result} | jq -r '.city')','$(echo ${result} | jq -r '.location.capital')','$(echo ${result} | jq -r '.location.languages[0].name')','$(echo ${result} | jq -r '.location.languages[1].name')');"
   mysql -usridhar -psridhar -h first_mysqlService -D geoLocation -e "INSERT INTO geoLocation (ip,type,continent_name,country_name,region_name,city,capital,language1,language2) VALUES ('$(echo ${result} | jq -r '.ip')','$(echo ${result} | jq -r '.type')','$(echo ${result} | jq -r '.continent_name')','$(echo ${result} | jq -r '.country_name')','$(echo ${result} | jq -r '.region_name')','$(echo ${result} | jq -r '.city')','$(echo ${result} | jq -r '.location.capital')','$(echo ${result} | jq -r '.location.languages[0].name')','$(echo ${result} | jq -r '.location.languages[1].name')');"
   echo "DETAILS HAS BEEN STORED IN THE DATABASE..."
else
   echo "THERE IS AN ERROR IN FETCHING DATA FROM API..."
fi
