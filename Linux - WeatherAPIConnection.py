from datetime import datetime #we will need date and time
import requests #python module that handles http requests, includint REST API calls
import json #we will be using the json module
FileLine = "" #this will be the line we write in the file at the end
UrlToCheck = "https://api.openweathermap.org/data/2.5/weather?lat=45.87&lon=22.91&units=metric&appid=274906d536ae27f7b4e0a952f0cd102b" #the URL complete with my API key
try: #we might get errors, so work with "try"
    response = requests.get(UrlToCheck) #this is the API call with API key included
    response.raise_for_status() #catch the exceptions

except requests.exceptions.HTTPError as errh:
    FileLine = "HTTP Error " + str(response.status_code)
    raise SystemExit(errh)
except requests.exceptions.ConnectionError as errc:
    FileLine = "Connection Error " + str(response.status_code)
    raise SystemExit(errc)
except requests.exceptions.Timeout as errt:
    FileLine = "Timeout Error " + str(response.status_code)
    raise SystemExit(errt)
except requests.exceptions.RequestException as err:
    FileLine = "Catastrophic Error " + str(response.status_code)
    raise SystemExit(err)

if (response.status_code == 200):
    # print(response.json()) #DEBUG content of the response. It is a dict object
    # print("response code is: ", response.status_code) #DEBUG status code. 200 means we got a good response
    # print(response.content)
    raspuns = response.json() #this dict contains the content
    # print(raspuns['main']) #DEBUG this is how you access the data in the response
    # print(raspuns['weather'][0]['id']) #DEBUG just to give an idea
    FileLine += raspuns['name'] + " - " # add the location
    FileLine += raspuns['weather'][0]['description'] + " - " #add weather description
    FileLine += str(raspuns['main']['temp']) + " - " #add temperature
    FileLine += str(raspuns['main']['humidity']) + " - " #add humidity
    FileLine += str(raspuns['wind']['speed']) + " - " #wind speed
    FileLine += str(raspuns['wind']['deg']) + "\n" #add wind direction - might use that in a nice graph later + newline
    #FileLine will have: the location, weather description, temperature, humidity, wind speed and wind direction in degrees
    
else:
    FileLine = "Error " + str(response.status_code)

dt_string=datetime.now().strftime("%Y-%m-%d %H:%M:%S") #write the date and the time in an SQL-compatible way in a string
# print(dt_string) #DEBUG
FileLine = dt_string + " - " + FileLine #add date + time at the beginning of the string
print(FileLine) #for debug purposes

with open("/project/WeatherList.txt", 'a') as f: # Open / create the file. 'a' for Append, 'w' for overWrite. 
    # This method also ensures that the file is closed after we're done
    # Each line in the file has: Date / time - location - weather desc. - temp - humidity - wind speed - wind direction  
    f.write(FileLine) # write the line in the file

