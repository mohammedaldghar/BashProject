export LC_COLLATE=C
shopt -s extglob

select choice in CreateTable ListTables InsertTable UpdateTable DeleteTable DropTable Back
do
    case $choice in 
        CreateTable)
        #echo "Create table"
	. createTable.sh
    ;;
	ListTables)
	ls
	;;
        InsertTable)
        echo "InsertTable"
    ;;
        UpdateTable)
        echo "UpdateTable"
    ;;
        DeleteTable)
        echo "DeleteTable"
    ;;
        DropTable)
        echo "DropTable"
    ;;
        Back)
        echo "Backing"
        cd ~/DataBase
        break
        ;;
        *)
        echo "Default"
    ;;
    esac
echo '1)CreateTable       2)ListTables       3)InsertTable       4)UpdateTable       5)DeleteTable       6)DropTable       7)Back'
done
