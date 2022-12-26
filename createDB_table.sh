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
<<<<<<< HEAD
        break
    ;;
=======
        echo "Backing"
        cd ~/DataBase
        break
        ;;
>>>>>>> 703494e7f94eda020166b47b36c43c15c8f9c543
        *)
        echo "Default"
    ;;
    esac
done
