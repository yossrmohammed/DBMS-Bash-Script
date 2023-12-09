#! /bin/bash
 flag=0
 if [[ $1 =~ ^[0-9] ]]
 then
 flag=1
 elif [[ $1 == *['!'@#\$%^\&*()_+]* ]] 
 then 
 flag=2
 fi
echo $flag