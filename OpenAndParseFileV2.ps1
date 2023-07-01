#resultArray = ''

foreach ($line in [System.IO.File]::ReadLines("C:\Users\adisi\Documents\GitHub\SQL-Project\WeatherList.txt")) {
    $weatherDate, $location, $description, $temperature, $humidity, $windSpeed, $windDirection = $line -split " - "
    Write-Host($windDirection)
}