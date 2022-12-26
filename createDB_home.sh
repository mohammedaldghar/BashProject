export LC_COLLATE=C
shopt -s extglob
#export PS3= " >> "
valid='*[a-zA-Z]';
regex='*([0-9]!@#$%^&*()_-+=/))';


#Check for parent director existence
if [ -d ~/DataBase ];then
    cd ~/DataBase
else
    mkdir ~/DataBase
    cd ~/DataBase
fi

#List some options to create database
select choice in 1-CreateDB 2-ListDB 3-DropDB 4-ConnectToDB  5-Exit
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
            echo "DataBase Connected Successfully"
            createDB_table.sh
        else 
            echo "DataBase Name Is Not Exist !!!"
        fi
    ;;
        5-Exit)
        break
        ;;
            *)
        echo "Wrong Input"
    ;;
    esac
echo "1)CreateDB  2)ListDB   3)DropDB   4)ConnectToDB    5)Exit"
done
