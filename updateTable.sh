#! /bin/bash
echo "Tables in $1 database are: "
for table in $(ls -I "*.table_primarykey"); do
    echo $table
done
read -p "Enter table name: " TableName
while true; do
    PS3="What do you want to do?"
    flag=0
    for table in $(ls); do
        if [ $table = $TableName ]; then
            flag=1
            break
        fi
    done
    if ((flag == 0)); then
        echo Incorrect name , no tbale with this name
    elif ((flag == 1)); then
        coulmns=$(awk ' BEGIN{ FS=","}
{
    if(NR == 1){
        for(i=1;i<=NF;i++){
           print $i  
        }
    }

}' ./$TableName)
        noOfCols=$(echo $coulmns | wc -w)

        select option in updateRow updateColumn; do
            case $option in
            "updateRow")
                select col in $coulmns; do
                    if (($REPLY > $noOfCols)); then
                        echo invalid
                    else
                        currentCol=$REPLY
                        datatype=$(echo $col | cut -d\( -f2 | cut -d\) -f1)
                        read -p "Enter  value: " oldValue
                        exist=$(cut -d"," -f $currentCol ./$TableName | grep -w $oldValue)

                        if [[ -n "$exist" ]]; then
                            read -p "Enter new value: " newValue
                        else
                            echo no $col wirh this name
                            break
                        fi
                        pk=$(cut -f1 ./$TableName"_primarykey")
                        if [[ $col = $pk ]]; then
                            while cut -d"," -f $currentCol "$TableName" | grep -w "$newValue"; do
                                if [[ -z $newValue ]]; then
                                    echo "Cannot be empty"
                                    read data
                                else
                                    echo "Error !! : ( $newValue ) already exists in the primary key column."
                                    read -p "Enter new value agian: " newValue
                                fi

                            done
                        fi
                        case $datatype in
                        "string")
                            if [[ $newValue =~ ^[a-zA-Z0-9]+$ ]]; then
                                awk -v oldval="$oldValue" -v newval="$newValue" -v col="$currentCol" 'BEGIN{ FS="," ; OFS=","}
                        { 
                                if( $col == oldval ){
                                    $col=newval
                                    print $0
                                }
                                else {
                                    print $0
                                }

                            
                        }' ./$TableName >temp && mv temp ./$TableName

                            else
                                echo invalid datatype your input must be string
                            fi
                            break
                            ;;
                        "int")

                            if [[ $newValue =~ ^[0-9]+$ ]]; then
                                #sed -i  "s/\<$oldValue\>/$newValue/" ./$TableName

                                awk -v oldval="$oldValue" -v newval="$newValue" -v col="$currentCol" 'BEGIN{ FS="," ; OFS=","}
                        { 
                                if( $col == oldval ){
                                    $col=newval
                                    print $0
                                }
                                else {
                                    print $0
                                }

                            
                        }' ./$TableName >temp && mv temp ./$TableName
                            else
                                echo invalid datatype your input must be integer
                            fi
                            break
                            ;;

                        esac
                    fi
                done
                ;;
            "updateColumn")
                select col in $coulmns; do
                    if (($REPLY > $noOfCols)); then
                        echo invalid
                        break
                    else
                        currentCol=$REPLY
                        datatype=$(echo $col | cut -d\( -f2 | cut -d\) -f1)
                        exist=$(cut -d"," -f $currentCol ./$TableName | sed '1d')
                        
                        if [[ -z "$exist" ]]; then
                            echo no $col wirh this name
                            break

                        fi
                        pk=$(cut -f1 ./$TableName"_primarykey")
                        if [[ $col = $pk ]]; then
                        echo Error cannot update all $col with the same value because it is the praimary key!
                        break
                        fi
                        read -p "Enter new value: " newValue
                        case $datatype in
                        "string")
                            if [[ $newValue =~ ^[a-zA-Z0-9]+$ ]]; then
                                
                             awk  -v newval="$newValue" -v col="$currentCol" 'BEGIN{ FS="," ; OFS=","}
                        {       if(NR>1){
                                    $col=newval
                                    print $0
                                    }
                                    else{
                                       print $0 
                                    }
                                

                            
                        }' ./$TableName >temp && mv temp ./$TableName

                                
                               

                            else
                                echo invalid datatype your input must be string
                            fi
                            break
                            ;;
                        "int")

                            if [[ $newValue =~ ^[0-9]+$ ]]; then
                             awk  -v newval="$newValue" -v col="$currentCol" 'BEGIN{ FS="," ; OFS=","}
                        {       if(NR>1){
                                    $col=newval
                                    print $0
                                    }
                                    else{
                                       print $0 
                                    }
                                

                            
                        }' ./$TableName >temp && mv temp ./$TableName
                            
                            else
                                echo invalid datatype your input must be integer
                            fi
                            break
                            ;;

                        esac
                    fi
                done
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
            read -p "Enter Table name agian  : " TableName
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
