$sqlConnection = New-Object System.Data.SqlClient.SqlConnection
$sqlConnection.ConnectionString="Server=localhost; Database=Weather; User Id=automation; Password=********"
$sqlConnection.Open() #open the connection

$sqlCommand=$sqlConnection.CreateCommand()
$sqlCommand.CommandText="Select * from WeatherLog" #this is the SQL command

$sqlDataAdapter=new-object System.Data.SqlClient.SqlDataAdapter $sqlCommand #necessary to show the data
$dataSet = new-object System.Data.DataSet
$sqlDataAdapter.fill($dataSet)
$dataSet.Tables #fill the dataset with all the tables that the query returns

$sqlConnection.Close() #don't forget to close the connection