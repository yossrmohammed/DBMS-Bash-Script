#! /bin/bash
flag=0
cd ./DB
for file in `ls`
do
if [ $file = $1 ]
then 
flag=1
break 
else 
echo 
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
 rm -r ./$1
 echo database is removed 
 ;;
"N" | "n" | "NO" | "no")

;;
*)
echo wrong answer
;;
esac


fi