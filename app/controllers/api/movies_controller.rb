class Api::MoviesController < ApplicationController
  API_KEY = Rails.application.credentials.moviedb[:api_key]  
  API_URL = "https://api.themoviedb.org/3/discover/movie"

  def index
    url = API_URL
    key = API_KEY
    result = RestClient.get(url, params: 
      {api_key: key, language: "en-US", sort_by: "popularity.desc", include_adult: "false", page: "1"})
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
      title: movie["title"],
      release_date: movie["release_date"],
      poster_path: movie["poster_path"]
    }
  end
end
