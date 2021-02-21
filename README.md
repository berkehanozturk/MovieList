# MovieList

This project is   Movie List app   using https://api.themoviedb.org/ api for getting movies 

Users can see  list of  popular movies  by scrolling  with movies poster and movie title.
User can click to right top button to change the appearance of list.
When users click to the movie , they can go to the detail page which is contains movie rating and movie overview to get opinion about movie.
In detail page user can press the right top button to add movie top favourite list.
On MovieList Screen user can see their fav movies and search movie from popular movies.

Movie List app can support landScape mode  for users who loves using landScape.


You can download  my app from https://github.com/berkehanozturk/MovieList/ 


#Some Functions That I use 
fetchPopularMovies():   fetching popular movies with page count from api and append the result to movie list
isFavouriteMovie() : check for movie is favourite or not 
setupCollectionViewLayout(isGrid: Bool) -> UICollectionViewCompositionalLayout :  setting up collection view's layout with parametre isGrid
loadMore():  triggers when load more button is clicked. increase pageCount 1 and fetchpopular movies again
search(searchText: String) :  search function gets searchbartext and search for fetched movies
addIssueToFavourites(): add movie to favourite list  using user default
removeFromFavourites(): remove favourites from favourite list


# 1-Network
Contains Api targets   whic is useful for  creating apiTarget  that i created  TheMovieTarget Target  
TheMovieTarget  is responsible for setting  network request parameters. 
contains  baseUrl, path, parameters,method  
new requests can be expanded as required  when If the top cases  is written  user can easily expand the network layer
##### 1.2 - MultiTarget 
Main Class for sending Request  in this class you can configure your  request configuration as requestTimeout second.

# 2-Protocols 
Alertable protocol for showing alert.  ViewControl you want to show alert must conform this protocol.
PopularMovieResource protocol is  for fetching  popular movie request   

# 3 Helpers
GetPoster class has a static function name getPosterUrl  which gets 2 parameter width and poster path  and return full Url for poster.



# ASYNC IMAGE LOADING
setRemoteImage function is gettin url as parameter  and setting this url in background thread and save image to cache  and if a  image is in cahce dont download image from internet uses from cache








