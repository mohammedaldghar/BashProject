export LC_COLLATE=C
shopt -s extglob


typeset -i numberOfCol
declare -a colNames
typeset -i IsExist

IsExist=0;
numberOfCol=0;
declare -i tableExist=0;

read -p "Enter table name: " tableName

if [ -f $tableName ]; then
	echo "Table is already exist";
	tableExist=1;	
else 
	touch $tableName
	echo "Table Created successfully"
fi

while true
do
	if (( $tableExist == 1 ));then
		break;
	fi
	read -p "column name if you finish enter -1 : " col
	if (( $col == -1 )); then
		break
	else
		
		IsExist=0
		for (( i=0;i<$numberOfCol;i++ ))
		do
		if [[ $col = ${colNames[$i]} ]]; then
			echo " Column Exist ";
			IsExist=1;
			break;
		fi
		done
		if [[ $numberOfCol != 0 ]];then
			if [[ $IsExist == 0 ]];then
				echo -n ":" >> $tableName;
			fi
		fi
		if (( IsExist == 0 )); then
			colNames[$numberOfCol]=$col
			echo -n $col >> $tableName;
			numberOfCol=$numberOfCol+1
		fi

	fi
done
echo >> $tableName
for (( i=0; i<$numberOfCol; i++ ))
do
read -p "Enter ${colNames[$i]} data type: " colData
if (( $i != 0 )) && (( $i != $numberOfCol ));then
echo -n ":" >> $tableName;
fi
colMetaData[$i]=$colData
if (( $i == 0 ));then
echo -n $colData"(PK)" >> $tableName
else
echo -n $colData >> $tableName
fi
done
