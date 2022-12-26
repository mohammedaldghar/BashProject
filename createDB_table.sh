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
        createDB_home.sh
    ;;
        *)
        echo "Default"
    ;;
    esac
done