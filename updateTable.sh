#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob
declare columnNumber=0
declare colName
tableFlag=0
doublicateData=0
re='^[0-9]+$'

read -p "Enter Table Name : " tableName

if ! [[ -f $tableName ]]; then
    tableFlag=1
fi

if [[ $tableFlag == 0 ]]; then

    colNames=($(sed -n -e "s/:/ /g" -e "1p" ~/DataBase/$DBName/$tableName))

    read -r -p "Enter Column Name : " name

    for ((i = 0; i < ${#colNames[@]}; i++)); do
        if [[ $name == "${colNames[$i]}" ]]; then
            ((columnNumber = $i + 1))
        fi
    done

    colData=($(sed -n '3,$p' ./$tableName | cut -d: -f$columnNumber))

    read -r -p "Enter Data You Want To Change : " oldData
    read -r -p "Enter New Data : " newData
    echo "columnNumber" $columnNumber

    if [[ $columnNumber == 1 ]]; then
        for ((k = 0; k < ${#colData[@]}; k++)); do
            if [[ $newData == "${colData[$k]}" ]]; then
                echo "Can not make dublicate data in PK column... "
                doublicateData=1
                break
            fi
        done
    fi
    echo "doublicateData" $doublicateData

    if ! [[ $columnNumber == 0 ]]; then
        if [[ $doublicateData == 0 ]]; then

            colName=$(awk -v oldValue="$oldData" -v newValue="$newData" -v column="$columnNumber" -F: '
                BEGIN{i=0}
                {  
                    while(i < NR)
                    {
                        if($column==oldValue)
                        {
                            gsub(oldValue,newValue)
                            print $0
                        }
                        i++;
                    }
                }
                ' ~/DataBase/$DBName/"$tableName")

            echo "names : " "${colName[@]}"

            echo "colData : " "${colData[@]}"

            declare -i colDataLength=${#colData[@]}

            echo "colDataLength : " $colDataLength

            declare -i tmp
            counter=0

            for ((i = 0; i < $colDataLength; i++)); do

                if [[ ${colData[$i]} == $oldData ]]; then

                    echo "col oldData : " ${colData[$i]}
                    tmp=0
                    tmp=$i+3

                    if ! [[ $oldData =~ $re ]]; then
                        echo "CHARACTERS"
                        sed -i ''/"$oldData"/d'' ./$tableName

                    else
                        deleteLine[$counter]=$tmp
                        ((counter = $counter + 1))
                        echo "counter "$counter
                        echo "Temp : "$tmp
                        echo "INTERGER"
                        sed -i "$tmp d" ./$tableName
                    fi
                fi
            done
            # echo "array lines " "${deleteLine[@]}"
            # for ((i = $counter - 1; i >= 0; i--)); do
            #     sed -i "${deleteLine[$i]} d" ./$tableName
            # done

            echo "${colName[@]}" >>~/DataBase/$DBName/"$tableName"

            declare -a stColumn
            stColumn=($(sed -n '3,$p' ~/DataBase/$DBName/$tableName | cut -d: -f1))
            if [[ ${stColumn[0]} =~ $re ]]; then
                sort -n -t: -k1 -o ~/DataBase/$DBName/$tableName ~/DataBase/$DBName/$tableName
            else
                sort -t: -k1 -o ~/DataBase/$DBName/$tableName ~/DataBase/$DBName/$tableName
            fi
        fi
    else
        echo "Column is not exist!!!"
    fi
else
    echo "Table is not exist!!!"
fi
