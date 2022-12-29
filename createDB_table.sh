#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob

select choice in CreateTable ListTables InsertTable UpdateTable DeleteTable DropTable Back
do
    case $choice in 
        CreateTable)
        createTable.sh
    ;;
        ListTables)
        ls -l
    ;;
        InsertTable)
        insertTable.sh
    ;;
        UpdateTable)
        updateTable.sh
    ;;
        DeleteTable)
        deleteRecord.sh
    ;;
        DropTable)
        dropTable.sh
    ;;
        Back)
        cd ~/DataBase
        break
    ;;
        *)
        echo "Wrong Input"
    ;;
    esac
echo '1)CreateTable       2)ListTables       3)InsertTable       4)UpdateTable       5)DeleteTable       6)DropTable       7)Back'
done
