export LC_COLLATE=C
shopt -s extglob
#export PS3= " >> "
valid='+[a-zA-Z]';
#names mario and dghar


#Check for parent director existence
if [ -d ~/DataBase ];then
    cd ~/DataBase
else
    mkdir ~/DataBase
    cd ~/DataBase
fi

#List some options to create database
select choice in CreateDB ListDB DropDB ConnectToDB 'Press 5 to Exit'
do
    case $choice in 
        CreateDB )
        read -p "Enter DataBase Name : " DBName
        if test $DBName == valid ;then
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
            echo "DataBase Connected Successfully"
            createDB_table.sh
        else 
            echo "DataBase Name Is Not Exist !!!"
        fi
    ;;
        'Press 5 to Exit')
        break
        ;;
        *)
        echo "Wrong Input"
    ;;
    esac
done