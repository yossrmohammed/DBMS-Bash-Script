#! /bin/bash

flag=0

 cd ./DB
read  -p "Enter DataBase name : " dbName
valid=$( ../tableAndDBNamingValidations.sh $dbName ) 
while [ true ]
do
if (( valid == 1 ))
then
 echo Invalid starting database name with number

elif (( valid == 2 ))
then
 echo Invalid  database name contain special character with number
elif (( valid == 3 ))
then 
echo Invalid database name, you enter space!
elif (( valid == 0 ))  
then
for file in `ls `
do
if [ $file = $(echo $dbName | tr ' ' '_') ]
then
flag=1 
break
fi
done
if (( flag == 1 ))
then
echo Already exist
flag=0
else 
if [[ $dbName == *' '* ]]
then
echo "sorry I cant accept spaceses :( , i will sperate words with _"
 mkdir -v $(echo $dbName | tr ' ' '_')
else
mkdir -v $dbName
fi


break
fi
fi
read -p "Do you want to continue? " ans
case  $ans in 
"Y" | "y" | "YES" | "yes")
 read  -p "Enter DataBase name agian: " dbName
valid=$( ../tableAndDBNamingValidations.sh $dbName )
 ;;
"N" | "n" | "NO" | "no")

  break
;;
*)
echo wrong answer
;;
esac

done







