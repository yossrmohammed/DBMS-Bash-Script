#! /bin/bash
 flag=0
 if [[ $1 =~ ^[0-9] ]]
 then
 flag=1
 elif [[ $1 == *['!'@#\$%^\&*()+/]* ]] 
 then 
 flag=2
elif [[ $1 == '' ]] 
 then 
 flag=3
 fi
echo $flag