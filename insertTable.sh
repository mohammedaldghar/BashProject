export LC_COLLATE=C
shopt -s extglob
declare -a inpElements
declare -a colNames
declare -a constrains
declare -i counter=0;
declare -i numberOfLines
declare -a firstField
declare -i fieldIterator

read -p "Enter Table Name : " tName

if ! [[ -f $tName ]];then
    echo "Table is not Exist"
    createDB_table.sh
fi


invalid=0;
regex="^[0-9]+$";
regexChar="^[a-zA-Z]+[0-9]*";
# echo >> ~/DataBase/$DBName/$tName 
counter=`head -1 ~/DataBase/$DBName/$tName | awk -F: '{print NF}'`;
numberOfLines=`sed -n '3,$p' ~/DataBase/$DBName/$tName | wc -l`

#retrieve data of first column and store them in array (firstField)
# firstField=$(awk '
# BEGIN{FS=":";i=1}
# {
#     if(NR>2){
#         x[i]=$1
#         i++
#     }
# }
# END{for(i=1;i<=NF;i++){print x[i]}}
# ' ~/DataBase/$DBName/$tName)
#numbers of the first column
# echo ${firstField[@]}
((counter=$counter+1))


#array of PK column
fieldIterator=3
for (( i=0;i<$numberOfLines;i++ ))
do
    firstField[$i]=`sed -n "$fieldIterator"p ~/DataBase/$DBName/$tName | cut -d: -f1` 
    fieldIterator=$fieldIterator+1;       
done


#array of data type
constrains=($(sed -n -e "s/:/ /g" -e "2p" ~/DataBase/$DBName/$tName))
#array of column names
colNames=($(sed -n -e "s/:/ /g" -e "1p" ~/DataBase/$DBName/$tName))

echo "array colNames" ${colNames[@]}
echo "array elements" ${firstField[@]}
echo "array constrains" ${constrains[@]}

# declare -i firstFieldLenght=${#firstField[@]};
declare -i colNamesLenght=${#colNames[@]};
echo "col length : " $colNamesLenght;
for (( i=0;i<$colNamesLenght;i++ )) 
do

    read -p "Enter value ${colNames[$i]} : " inp

    if [[ $i == 0 && $inp =~ $regex ]];then
        flag=0;
        for (( j=0;j<$numberOfLines;j++ ))
        do
            if [[ $inp == ${firstField[$j]} ]];then
                echo ${colNames[$i]} $inp" Already Exist" 
                flag=1;
                break            
            fi
        done
        if [[ $flag == 0 ]];then
            inpElements[$i]=$inp;
            else
                break
        fi
    elif [[ $inp =~ $regexChar ]];then
        inpElements[$i]=$inp;
    elif [[ $inp =~ $regex ]];then
        inpElements[$i]=$inp
    else
        invalid=1;
        echo "not valid input"
    fi
            
done

declare -i inpElementsLength=${#inpElements[@]};

for (( i=0;i< $inpElementsLength;i++ ))
do
    if [[ $invalid == 1 ]];then
        break
    fi
    if  [[ $i != 0 ]];then
        echo -n ":" >> ~/DataBase/$DBName/$tName 
    fi
    echo -n ${inpElements[$i]} >> ~/DataBase/$DBName/$tName 
done

# echo "${x// /*}"
# echo "${inpElements[@]// /:}" >> ~/DataBase/$DBName/$tName 