export LC_COLLATE=C
shopt -s extglob

declare -a colNames
regexNum='^[0-9]+$';
regexChar='^[a-zA-Z]+[0-9]*';
flag=0
declare -i colNumber
read -p "Enter table name : " tableName
colNames=($(sed -n -e "s/:/ /g" -e "1p" ./$tableName))
declare -i colLength=${#colNames[@]}
if [ ! -f $tableName ]; then
	echo "Table is not exist";
createDB_table.sh
fi
select choice in DeleteByColumnName DeleteAll Back
do
case $choice in
DeleteByColumnName)
read -p "Enter column name: " colName
for (( i=0;i<$colLength;i++ ))
do
if [[ $colName == ${colNames[$i]} ]];then
flag=1
colNumber=$i;
echo $colNumber;
break;
fi
done
if (( $flag==0 ));then
echo "this column is not exist"
else
colNumber=$colNumber+1
colData=($(sed -n '3,$p' ./$tableName| cut -d: -f$colNumber))
echo "colData" ${colData[@]};
declare -i colDataLength=${#colData[@]};
echo "colDataLength" $colDataLength
read -p "Enter data you want to delete: " data
	for (( j=0;j<$colDataLength;j++ ))
	do
		if [[ ${colData[$j]} == $data ]];then
			declare -i tmp=0
			((tmp=$j+2));
				if [[ $regexNum == $data ]];then
					`sed -i "$tmp d" ./$tableName`
					echo "with if"
					break;
				else
					sed -i ''/"$data"/d'' ./$tableName
					echo "with else with temp"
					break;
				fi

			else
				if [[ $regexNum =~ $data ]];then
					`sed -i "$tmp d" ./$tableName`
					echo "with if"
					break;
				else
					sed -i ''/"$data"/d'' ./$tableName
					echo "with else"
					break;
				fi
		else
			echo "Not Found"
		fi
	done
#cut -d: -f$colNumber ./$tableName | sed -i ''/"$data"/d'' > ./$tableName
#sed -i ''/"$data"/d'' > ./$tableName
#grep -n $data ./$tableName
fi
;;
DeleteAll)
	sed  -i '3,$d' ./$tableName
	break
;;
Back)
break
;;
*)
echo "It's not option"
;;
esac
flag=0
echo "1)DeleteByColumnName   2)DeleteAll   3)Back"
done
