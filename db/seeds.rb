# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

require "open-uri"
require 'json'
url = URI("http://tmdb.lewagon.com/movie/top_rated?language=en-US&page=1")

Bookmark.destroy_all
puts "we need to destroy bookmarks first ☠️"
Movie.destroy_all
puts "Existing movies destroyed! ☠️"
List.destroy_all
puts "Existing lists destroyed! ☠️"

puts "Now seeding new movies 🌱"
document = URI.open(url).read
json_doc = JSON.parse(document)
thirty_movies = json_doc["results"][..29]

thirty_movies.each do |movie|
  new_movie = Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    rating: movie["vote_average"],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}"
  )
  print '🍿'
end

puts "You created 30 Movies with poster urls! 🍿"

lists = ["Family", "Nostalgia", "Cult", "Animation", "Recommended", "Cheesy", "Art-House"]
puts "Shall we create some lists now? 🎬"
lists.each do |list|
  List.create(name: list)
  puts "Movie List '#{list}' is created."
end

puts "Time for some CSS now."
