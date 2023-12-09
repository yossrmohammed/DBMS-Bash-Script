#! /bin/bash

flag=0
 cd ./DB
ls 
for file in `ls `
do
if [ $file = $1 ]
then

flag=1  
break

fi
done
if (( flag == 1 ))
then
echo Already exist
else 
mkdir -v ./$1 
fi




