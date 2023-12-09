#! /bin/bash

#if there is no db dir make one
if [ ! -d "DB" ]
then
mkdir -v ./DB
fi
select option in CreateDataBase ListDataBase ConnectToDataBase DropDataBase exit
do
case $option in
"CreateDataBase")
read -p "Enter DataBase name : " dbName
valid=$( ./tableAndDBNamingValidations.sh $dbName )  
if (( valid == 0 ))
then
./createDB.sh  $dbName
elif (( valid == 1 ))
then
 echo Invalid starting database name with number

elif (( valid == 2 ))
then
 echo Invalid  database name contain special character with number

fi
;;
"ListDataBase")
./listdatabase
;;
"ConnectToDataBase")
./connect
;;
"DropDataBase")
read -p "Enter DataBase name : " dbName

valid=$( ./tableAndDBNamingValidations.sh $dbName )  
if (( valid == 0 ))
then
./dropDB.sh $dbName
elif (( valid == 1 || valid == 2 ))
then
 echo Invalid name 
fi
;;
"exit")
echo "Good bye :)"
break
;;

*)
echo "Invalid Option please choose right option :)"

esac
done