#! /bin/bash

#if there is no db dir make one
if [ ! -d "DB" ]
then
mkdir -v ./DB
fi

PS3="Welcome back:) , choose your operation: "
select option in CreateDataBase ListDataBase ConnectToDataBase DropDataBase exit
do
case $option in
"CreateDataBase")

./createDB.sh  

;;
"ListDataBase")
./listdatabase
;;
"ConnectToDataBase")
./connect
;;
"DropDataBase")

if (( valid == 0 ))
then
./dropDB.sh #$dbName
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