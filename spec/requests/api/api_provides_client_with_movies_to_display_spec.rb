# frozen_string_literal: true

RSpec.describe Api::MoviesController, type: :request do
  let(:movies) { 5.times { create(:movie) } }
  describe 'successfully GET a collection of movies' do

    before do
      get '/api/movies'
    end

    it 'is expected to return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return five movies' do
      expect(response_json['movies'].count).to eq 5
    end
  end
end