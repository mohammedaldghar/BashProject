#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob
declare -a colData
declare -a colNames
re='^[0-9]+$'
regexChar='^[a-zA-Z]+'
flag=0
declare -i colNumber
declare -a deleteLine
declare -i counter
read -p "Enter table name : " tableName

colNames=($(sed -n -e "s/:/ /g" -e "1p" ./$tableName))

declare -i colLength=${#colNames[@]} #len=3
echo "${!colNames[@]}"
echo "${colNames[@]}"

if [ ! -f $tableName ]; then
	echo "Table is not exist"
	createDB_table.sh
fi


select choice in DeleteByColumnName DeleteAll Back; do
	case $choice in
	DeleteByColumnName)
		read -p "Enter column name: " colName
		for ((i = 0; i < $colLength; i++)); do
			if [[ $colName == ${colNames[$i]} ]]; then
				flag=1
				colNumber=$i
				echo $colNumber
				break
			fi
		done
		if (($flag == 0)); then
			echo "this column is not exist"
		else
			colNumber=$colNumber+1

			colData=($(sed -n '3,$p' ./$tableName | cut -d: -f$colNumber))

			echo "colData : " "${colData[@]}"

			declare -i colDataLength=${#colData[@]}

			echo "colDataLength : " $colDataLength #len=7
			
			declare -i tmp
			counter=0
			read -p "Enter data you want to delete: " data

			for ((i = 0; i < $colDataLength; i++)); do #0 ---> 7-1 = 6

				if [[ ${colData[$i]} == $data ]]; then

					echo "col data : " ${colData[$i]};
					tmp=0
	
				tmp=$i+3

					if ! [[ $data =~ $re ]] ; then
							echo "CHARACTERS";
							sed -i ''/"$data"/d'' ./$tableName
							# break
							
						else
							deleteLine[$counter]=$tmp;
							((counter=$counter+1))
							echo "counter "$counter
								echo "Temp : "$tmp
								echo "INTERGER"
								#sed -i "$tmp d" ./$tableName
								# break
						fi
				else
					echo "Not Found"
				fi
			done
			echo "array lines " "${deleteLine[@]}"
			for (( i=$counter-1;i>=0;i-- ))
			do								
				sed -i "${deleteLine[$i]} d" ./$tableName
			done
		#cut -d: -f$colNumber ./$tableName | sed -i ''/"$data"/d'' > ./$tableName
		#sed -i ''/"$data"/d'' > ./$tableName
		#grep -n $data ./$tableName
		fi
	;;
	DeleteAll)
		sed -i '3,$d' ./$tableName
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
	echo "1)DeleteByColumnName         2)DeleteAll         3)Back"
done
