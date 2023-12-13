#! /bin/bash
read -p "Enter table name/: " TableName
if [ ! -f $TableName ]
then
echo no table with this name 
else
select option in updateWithRaw UpdateWithColum
do
case $option in
"pdateWithRaw") 
;;
"UpdateWithColum") 

;;
esac

done
fi