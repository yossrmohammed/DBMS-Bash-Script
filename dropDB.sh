#! /bin/bash
flag=0

cd ./DB
read -p "Enter DataBase name : " dbName
valid=$( ../tableAndDBNamingValidations.sh $dbName )  
while [ true ]
do
if (( valid == 0 ))
then
for file in `ls`
do
if [ $file = $dbName ]
then 
flag=1
break 

fi
done
if (( flag == 0 ))
then
echo Incorrect name , no database with this name
elif  (( flag == 1 ))
then
read -p "Are you sure?" ans
case  $ans in 
"Y" | "y" | "YES" | "yes")
 rm -r ./$dbName
 end=1
 break
 echo database is removed 
 ;;
"N" | "n" | "NO" | "no")
break
;;
*)
echo wrong answer
;;
esac

fi
else
 echo Invalid name 
fi
read -p "Do you want to continue? " answer
case  $answer in 
"Y" | "y" | "YES" | "yes")
read -p "Enter DataBase name : " dbName
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
