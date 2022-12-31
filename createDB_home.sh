#!/usr/bin/bash

export LC_COLLATE=C
shopt -s extglob
export PS3='>>> '
valid='^[a-zA-Z]+'
regex='^[!@#$%^&*:;.()_-+=/)]*$'
export DBName

if [ -d ~/DataBase ]; then
    cd ~/DataBase || exit
else
    mkdir ~/DataBase
    cd ~/DataBase || exit
fi

#List some options to create database
select choice in CreateDB ListDB DropDB ConnectToDB Exit; do
    cd ~/DataBase/ || exit
    case $choice in
    CreateDB)
        read -r -p "Enter DataBase Name : " DBName
        if [[ $DBName =~ $valid && $DBName != *' '* && $DBName != $regex ]]; then
            if [ -d $DBName ]; then
                echo "DataBase Name Already Exist !!!"
            else
                mkdir ./$DBName
                echo "DataBase Created Successfully !!!"
            fi
        else
            echo "Wrong Input Format."
        fi
        ;;
    ListDB)
        echo "DataBase ListDB : "
        ls -F ~/DataBase | grep /
        ;;
    DropDB)
        echo "DataBase DropDB"
        read -r -p "Enter DataBase Name : " DBName
        if [ -d $DBName ]; then
            echo "DataBase Found"
            rm -r $DBName
            echo "DataBase Removed Successfully"
        else
            echo "DataBase Name Is Not Exist !!!"
        fi
        ;;
    ConnectToDB)
        echo "DataBase ConnectToDB"
        read -p "Enter DataBase Name : " DBName
        if ! [[ $DBName =~ $valid ]]; then
            echo "Name Can't be empty !!!"
            continue
        fi
        if [ -d $DBName ]; then
            echo "DataBase Found"
            cd ~/DataBase/$DBName || exit
            echo "DataBase Connected Successfully to $DBName"
            pwd
            createDB_table.sh
        else
            echo "DataBase Name Is Not Exist !!!"
        fi
        ;;
    Exit)
        echo "Bye..."
        break
        ;;
    *)
        echo "Wrong Input"
        ;;
    esac
    echo "1)CreateDB          2)ListDB          3)DropDB          4)ConnectToDB        5)Exit"
done
