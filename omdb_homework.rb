require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
  html = %q(
  <html><head><title>Movie Search</title></head><body>
  <h1>Find a Movie!</h1>
  <form accept-charset="UTF-8" action="/result" method="post">
    <label for="movie">Search for:</label>
    <input id="movie" name="movie" type="text" />
    <input name="commit" type="submit" value="Search" /> 
  </form></body></html>
  )
end

post '/result' do
search_str = params[:movie]
# This contacts omdbapi and requests the search results which returns an array of hashes
response = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str })
result = JSON.parse(response.body)["Search"]

  html_str = "<html><head><title>Movie Search Results</title></head><body><h1>Movie Results</h1>\n<ul>"
# This will loop through the search results array and collects the values of keys: 
  result.each { |x|       # Title and Year and turns this into a link
  html_str += "<a href='/poster/#{x["imdbID"]}'><li>#{x["Title"]} - #{x["Year"]}</li></a>"}
  html_str += "</ul></body></html>"
end

get '/poster/:imdb' do |imdb_id|
# This contacts omdbapi again and requests the imdbID for the selected movie  
  response = Typhoeus.get("www.omdbapi.com", :params => {:i => imdb_id})
  result = JSON.parse(response.body)
# This adds the poster link in the img tag and links it with the title from above
  html_str = "<html><head><title>Movie Poster</title></head><body><h1>Movie Poster</h1>\n"
  html_str += "<h3>#{result["Title"]}</h3>"
  html_str += "<img src= #{result["Poster"]} /img>"
  html_str += '<br /><a href="/">New Search</a></body></html>'
end
