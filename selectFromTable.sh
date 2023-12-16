#! /bin/bash

echo "Tables in $1 database are: "
for table in `ls  `
do
echo $table
done

read -p "Enter Table name  : " tName

while [ true ]
do
PS3="What do you want to do?"
flag=0
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
select option in selectAll  SelectCoulmn selectRow
do
coulmns=$(awk  ' BEGIN{ FS=","}
{
    if(NR == 1){
        for(i=1;i<=NF;i++){
           print $i  
        }
    }

}' ./$tName)
case $option in 
"selectAll")
cut  -d"," --output-delimiter=' ' -f 1- ./$tName
break
;;
"SelectCoulmn")
PS3="Choose Coulmn: "
select col in $coulmns 
do
cut  -d"," --output-delimiter=' ' -f $REPLY ./$tName
break
done
break
;;
"selectRow")
PS3="Choose attribute: "
select col in $coulmns
do

noOfCol=$(echo $coulmns | wc -l ) 
if (( $REPLY <  $noOfCol ))
then 
echo invalid
else
read -p "Enter value: " value
line=$(cut  -d"," --output-delimiter=' ' -f 1- ./$tName | grep -w $value)
fi
if [[ -z $line ]]
then 
echo Sorry, no data match this value , may be you enter wrong value or no records with this value 
else
echo $line
fi
break
done
break
;;
*)
echo invalid option
;;
esac
done

fi
echo Do you want to continue ?
select ans in  yes no
do
case  $ans in 
 "yes")
read -p "Enter Table name agian  : " tName 
break
 ;;
 "no")
 exit 1
;;
*)
echo wrong answer
echo Do you want to continue ?
;;
esac
done
done