# marshplay
demo app for movie data



## Description

This demo app fetches  movie records from OMDB using following api:

http://www.omdbapi.com/?s=Batman&page=1&apikey=eeefc96f

* above api returns Json response
* **Codable** is used for handling Json
* Records are shown in **Collection view** (2 cells in a row in portrait mode)
* Poster images are cached using **Core data**.
* Records are fetches by page number when user scroll down (as there may be lots of records)
* A detail page is also there if a movie is selected.

