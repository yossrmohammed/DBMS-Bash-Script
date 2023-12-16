#! /bin/bash

echo "Tables in $1 database are: "
for table in $(ls); do
    echo $table
done

read -p "Enter Table name  : " tName

while [ true ]; do
    PS3="What do you want to do?"
    flag=0
    for table in $(ls); do
        if [ $table = $tName ]; then
            flag=1
            break
        fi
    done
    if ((flag == 0)); then
        echo Incorrect name , no tbale with this name
    elif ((flag == 1)); then
        select option in selectAll SelectCoulmn selectRow; do
            coulmns=$(awk ' BEGIN{ FS=","}
{
    if(NR == 1){
        for(i=1;i<=NF;i++){
           print $i  
        }
    }

}' ./$tName)
            noOfCols=$(echo $coulmns | wc -w)
            case $option in
            "selectAll")
                cut -d"," --output-delimiter=' ' -f 1- ./$tName
                break
                ;;
            "SelectCoulmn")
                PS3="Choose Coulmn: "
                select col in $coulmns; do
                    if (($REPLY > $noOfCols)); then
                        echo invalid
                        break
                    else
                        cut -d"," --output-delimiter=' ' -f $REPLY ./$tName
                        break
                    fi
                done
                break

                ;;
            "selectRow")
                PS3="Choose attribute: "
                select col in $coulmns; do

                    if (($REPLY > $noOfCols)); then
                        echo invalid
                        break
                    else
                        column=$REPLY
                        read -p "Enter value: " value
                        isexist=$(cut -d"," --output-delimiter=' ' -f $column ./$tName | grep -w $value)
                        if [[ -z $isexist ]]; then
                            echo Sorry, no data match this value , may be you enter wrong value or no records with this value
                        else
                         awk  -v val="$value" -v col="$column" 'BEGIN{ FS="," }
                        {       if(NR>1){
                                    if($col==val){
                                    print $0
                                    }
                                    }
                            
                        }' ./$tName 
                        fi
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
    select ans in yes no; do
        case $ans in
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
