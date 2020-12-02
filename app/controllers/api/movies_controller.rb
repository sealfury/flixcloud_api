class Api::MoviesController < ApplicationController
  def index
    movies = Movie.all 
    render json: { movies: movies }, status: 200
  end
end
