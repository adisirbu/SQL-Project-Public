#Check if WeatherList.txt exists
if (-Not(Test-Path "E:\Documente\Adi\Project-SQL\WeatherList.txt")) {
    Exit #terminate the script; there's nothing to write
}

$sqlQuery = '' #this is the query
#creating the variables that will hold the parameteres we insert into the database
$weatherDate = '' #the date
$location = '' #the location
$description = '' #the description
$temperature = 0.0 #the temperature
$humidity = 0 #the humidity
$windSpeed = 0.0 #the wind speed
$windDirection = 0 #the wind direction

$sqlConnection = New-Object System.Data.SqlClient.SqlConnection #create the connection
$sqlConnection.ConnectionString="Server=localhost; Database=Weather; User Id=automation; Password=AutomationSQL1" #connection parameters
$sqlConnection.Open() #open the connection

foreach ($line in [System.IO.File]::ReadLines("E:\Documente\Adi\Project-SQL\WeatherList.txt")) {
    #next 5 lines need to be executed for every line of the file
    #split each line of the file by " - " and assign each segment to a variable
    $weatherDate, $location, $description, $temperature, $humidity, $windSpeed, $windDirection = $line -split " - "
    $sqlCommand=$sqlConnection.CreateCommand() #create the command
    #now create the string that will be the SQL query
    $sqlQuery = "insert into WeatherLog (recordedAt, location, description, temperature, humidity, windSpeed, windDirection) values ('$weatherDate', '$location', '$description', $temperature, $humidity, $windSpeed, $windDirection)"
    $sqlCommand.CommandText=$sqlQuery #this is the actual SQL command passed to the database
    $sqlCommand.ExecuteNonQuery()
}

$sqlConnection.Close() #don't forget to close the connection

#Delete WeatherList.txt once it has been processed
Remove-Item "E:\Documente\Adi\Project-SQL\WeatherList.txt"