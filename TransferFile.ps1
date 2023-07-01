#This script will use passwordless scp to: 
# 1. copy the info from WeatherList to the local computer
# 2. copy the file "Transfer.txt" to the server to confirm the transfer was done and it is OK to empty the file
scp automation@192.168.100.150:/project/WeatherList.txt 'E:\Documente\Adi\Project-SQL'
scp 'E:\Documente\Adi\Project-SQL\Transfer.txt' automation@192.168.100.150:/project/