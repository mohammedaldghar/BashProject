export LC_COLLATE=C
shopt -s extglob
#export PS3= " >> "
<<<<<<< HEAD
valid='*[a-zA-Z]';
regex='*([0-9]!@#$%^&*()_-+=/))';

=======
valid='+[a-zA-Z]';
regex='[0-9][!@#$%^&*()_-+=/)]';
>>>>>>> 703494e7f94eda020166b47b36c43c15c8f9c543

#Check for parent director existence
if [ -d ~/DataBase ];then
    cd ~/DataBase
else
    mkdir ~/DataBase
    cd ~/DataBase
fi

#List some options to create database
<<<<<<< HEAD
select choice in 1-CreateDB 2-ListDB 3-DropDB 4-ConnectToDB  5-Exit
=======
select choice in CreateDB ListDB DropDB ConnectToDB Exit
>>>>>>> 703494e7f94eda020166b47b36c43c15c8f9c543
do
    case $choice in 
        1-CreateDB )
        read -p "Enter DataBase Name : " DBName
        if [[ $DBName != $regex ]];then
            if [ -d $DBName ];then
                echo "DataBase Name Already Exist !!!"
            else 
                mkdir ./$DBName
                echo "DataBase Created Successfully !!!"
            fi
        else
          echo "Wrong Input Format."
        fi
    ;;
        2-ListDB )
        echo "DataBase ListDB : "
        ls -F ~/DataBase | grep /
    ;;
        3-DropDB )
        echo "DataBase DropDB"
        read -p "Enter DataBase Name : " DBName
        if [ -d $DBName ];then
            echo "DataBase Found"
            rm -r $DBName
            echo "DataBase Removed Successfully"
        else 
            echo "DataBase Name Is Not Exist !!!"
        fi
    ;; 
        4-ConnectToDB )
        echo "DataBase ConnectToDB"
         read -p "Enter DataBase Name : " DBName
        if [ -d $DBName ];then
            echo "DataBase Found"
            cd ~/DataBase/$DBName
            echo "DataBase Connected Successfully to $DBName"
            pwd
            . createDB_table.sh
        else 
            echo "DataBase Name Is Not Exist !!!"
        fi
    ;;
<<<<<<< HEAD
        5-Exit)
=======
        Exit)
>>>>>>> 703494e7f94eda020166b47b36c43c15c8f9c543
        break
        ;;
            *)
        echo "Wrong Input"
    ;;
    esac
<<<<<<< HEAD
echo "1)CreateDB  2)ListDB   3)DropDB   4)ConnectToDB    5)Exit"
done
=======
    echo "1)CreateDB          2)ListDB          3)DropDB          4)ConnectToDB          5)Exit"
done
>>>>>>> 703494e7f94eda020166b47b36c43c15c8f9c543
