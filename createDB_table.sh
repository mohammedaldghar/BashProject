export LC_COLLATE=C
shopt -s extglob

select choice in CreateTable InsertTable UpdateTable DeleteTable DropTable Back
do
    case $choice in 
        CreateTable)
        echo "Create table"
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
done