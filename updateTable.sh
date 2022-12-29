#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob
declare columnNumber=0
declare colName
re='^[0-9]+$'

read -p "Enter Table Name : " tableName

if ! [[ -f $tableName ]]; then
    echo "Table is not Exist"
    createDB_table.sh
fi
colNames=($(sed -n -e "s/:/ /g" -e "1p" ./$tableName))

read -r -p "Enter Column Name : " name

for (( i=0;i<${#colNames[@]};i++ ))
do
    if [[ $name == "${colNames[$i]}" ]];then
        ((columnNumber="$i"+1));
    fi
done

echo $columnNumber

read -r -p "Enter Data You Want To Change : " oldData
read -r -p "Enter New Data : " newData

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

# delete line number stored in shell variable $n
# awk -v n=$n 'NR == n {next} {print}' ~/DataBase/$DBName/$tableName

echo "names : " "${colName[@]}"

# built in function ------> strtonum -------> convert string to number
# select $tableName in



colData=($(sed -n '3,$p' ./$tableName | cut -d: -f$columnNumber))

echo "colData : " "${colData[@]}"

declare -i colDataLength=${#colData[@]}

echo "colDataLength : " $colDataLength #len=7

declare -i tmp
counter=0

for ((i = 0; i < $colDataLength; i++)); do #0 ---> 7-1 = 6

    if [[ ${colData[$i]} == $oldData ]]; then

        echo "col oldData : " ${colData[$i]};
        tmp=0
        tmp=$i+3

        if ! [[ $oldData =~ $re ]] ; then
                echo "CHARACTERS";
                sed -i ''/"$oldData"/d'' ./$tableName
                # break
                
            else
                deleteLine[$counter]=$tmp;
                ((counter=$counter+1))
                echo "counter "$counter
                    echo "Temp : "$tmp
                    echo "INTERGER"
                    sed -i "$tmp d" ./$tableName
                    # break
        fi
    fi
done
echo "array lines " "${deleteLine[@]}"
			for (( i=$counter-1;i>=0;i-- ))
			do								
				sed -i "${deleteLine[$i]} d" ./$tableName
			done

echo "${colName[@]}" >> ~/DataBase/$DBName/"$tableName"