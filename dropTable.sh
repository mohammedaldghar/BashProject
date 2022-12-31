#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob

read -r -p "Enter table name: " tableName

if [[ -f $tableName ]]; then
	rm "$tableName"
	echo "Deleted Successfully"
else
	echo "Table is not Exist"
fi
