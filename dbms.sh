#! /bin/bash

select option in CreateDataBase ListDataBase ConnectToDataBase DropDataBase exit
do
case $option in
"CreateDataBase")
echo $option
;;
"ListDataBase")
echo $option
;;
"ConnectToDataBase")
echo $option
;;
"DropDataBase")
echo $option
;;
"exit")
echo "Good bye :)"
exit 1
;;

*)
echo "Invalid Option please choose right option :)"

esac
done