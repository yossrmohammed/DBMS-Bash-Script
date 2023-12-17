#! /bin/bash

echo "Tables in $1 database are: "
for table in `ls  -I "*.table_primarykey"  `
do
echo $table
done
read -p "Enter Table name  : " tName
flag=0
while [ true ]
do
while [[ -z $tName ]]
do
echo invlaid empty name
read -p "Enter Table name agian  : " tName 
done
for table in `ls`
do
if [ $table = $tName ]
then 
flag=1
break 
fi
done
if (( flag == 0 ))
then
echo Incorrect name , no tbale  with this name
elif  (( flag == 1 ))
then
read -p "Are you sure?" ans
case  $ans in 
"Y" | "y" | "YES" | "yes")
 rm -r ./$tName ./$tName"_primarykey"
 echo table is removed 
 break
 ;;
"N" | "n" | "NO" | "no")
break;
;;
*)
echo wrong answer
;;
esac
fi
read -p "Do you want to continue? " ans
case  $ans in 
"Y" | "y" | "YES" | "yes")
read -p "Enter Table name agian  : " tName 
 ;;
"N" | "n" | "NO" | "no")
break
;;
*)
echo wrong answer
;;
esac

done


