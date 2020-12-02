RSpec.describe 'GET /api/movies', type: :request do
  
  describe 'with title as query parameters' do
     before do
       get '/api/movies'
     end

    it 'is expected to return a 200 respons' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return a title' do
      expected_response_body = {
        "title": "Chick Fight"
      }.as_json

      # poster
      # release date
      # genre

      expect(response_json["movies"].first).to eq expected_response_body
    end
  end
end