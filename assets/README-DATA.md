# Database structure

For each city, country and continent exists a separate .json file.
For each suggestion exists a comma separated object inside an array inside the dart file "Suggestions.dart"
If a city has less than 50/100 results, we show the results of the state (there exists no separate file for the city and the file lookup will throw an exception)

## File naming convention

a-ven-car.json <- America-Venezuela-Caracas
e-spa-bar.json <- Europe-Spain-Barcelona
as-jap-tok.json <- Asia-Japan-Tokyo
au-nsw-sid.json <- Australia-New South Wales-Sidney (All states beginning with new are sorted differently)
a-nha-por.json <- America-New Hampshire-Portsmouth (U.S.A. does not exist in this database because it is a military not regional classification, just like NATO or EU which is not Europe)
af-nig-lag.json <- Africa, Nigeria, Lagos
e.json <- Europe (contains an array of all the filenames within europe)
am.json <- America
e-spa.json <- Europe, Spain (contains an array of all the filenames within spain)

## Search algorithm

Comma separated suggestion object: 'Barcelona - Spain - Europe, e-spa-bar, city',

The user searches for "Caracas" -> We suggest him to choose "Caracas, Venezuela, America"
The user hits the suggestion and the data search is initialized::
1. Get the filename from the SuggestionMatch.fileName property
2. Open the file and show all the results

The user searches for "Vegan" -> We suggest him to choose "Vegan"
1a. Get all the places from the places.json containing all places worldwide
1b. Get all the filenames from all the locations, load each file, search them for the tag
2. Show all the results sorted by locations and optionally if we have the location of the user we can sort the list

(optional as it involves dependency for places api and requires permission to grab user location and we can assume that each user knows where he wants to search) 
We have the location of the user and google api tells us that this point is located in Barcelona, Spain - https://developers.google.com/places/web-service/autocomplete
1. We pretend to make a selection like a user on the Suggestion of the corresponding state and we get returned the fileName
2. We load the data from Spain out of the file "e-spa.json" which contains an array with all the fileNames of the cities in Spain
3. We load the data from Barcelona, Madrid, Benidorm, Tarifa and show them to the user