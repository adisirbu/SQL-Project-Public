#resultArray = ''

foreach ($line in [System.IO.File]::ReadLines(".\WeatherList.txt")) {
    Write-Host $line
    #resultArray = $line.split(" - ")
    #Write-Host(resultArray)
}