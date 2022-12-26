# export LC_COLLATE=C
# shopt -s extglob

awk '
BEGIN{FS = ":";i=0}
{
    while(i < NF)
    {
        print();
        i++;
    }
}
END{}
' 


#~\DataBase\$DBName\$tableName