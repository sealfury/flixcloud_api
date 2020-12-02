class Api::MoviesController < ApplicationController
  def index
    # movies = Movie.all ### TA BORT NYCKELN, lägg i credentials istället. 
    result = RestClient.get()
    body = JSON.parse(result.body)
    movies = sanitized_movies(body)  

    render json: { movies: movies }, status: 200
  end

  private
  def sanitized_movies(body)
    sanitized_movies = []
    array = body["results"]
    array.each do |movie|
    sanitized_movies.push format_movie(movie)
    end
    sanitized_movies
  end

  def format_movie(movie)
    {
      title: movie["title"]
# poster: add to test, add to db
# releasedate: add to test, add to db
# genre: add to test, add to db
# Take care of key in two places

    }
  end

end
