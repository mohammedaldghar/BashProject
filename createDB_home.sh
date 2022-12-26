export LC_COLLATE=C
shopt -s extglob
export PS3='>>> ';
<<<<<<< HEAD
valid='+[a-zA-Z]';
regex='[0-9][!@#$%^&*()_-+=/)]';
=======
valid=`+[[a-zA-Z0-9]]`;
#regex='+[[0-9][!@#$%^&*()_-+=/)]]';
>>>>>>> d5a73bf88110b21b38fb137bd8b209218e7a8057

#Check for parent director existence
if [ -d ~/DataBase ];then
    cd ~/DataBase
else
    mkdir ~/DataBase
    cd ~/DataBase
fi

#List some options to create database
select choice in CreateDB ListDB DropDB ConnectToDB Exit
do
    case $choice in 
        CreateDB )
        read -p "Enter DataBase Name : " DBName
        if [[ $DBName = $valid ]];then
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
        ListDB )
        echo "DataBase ListDB : "
        ls -F ~/DataBase | grep /
    ;;
        DropDB )
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
        ConnectToDB )
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
        Exit)
        break
        ;;
            *)
        echo "Wrong Input"
    ;;
    esac
<<<<<<< HEAD
    echo "1)CreateDB          2)ListDB          3)DropDB          4)ConnectToDB        5)Exit"
done
=======
    echo "1)CreateDB          2)ListDB          3)DropDB          4)ConnectToDB          5)Exit"
done
>>>>>>> d5a73bf88110b21b38fb137bd8b209218e7a8057
