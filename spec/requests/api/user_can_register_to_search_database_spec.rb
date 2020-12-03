# frozen_string_literal: true

RSpec.describe 'POST "/api/auth"', type: :request do

  describe 'with valid credentials' do
    before do
      post '/api/auth',
        params: {
          name: 'Arthur',
          email: 'user@mail.com',
          password: 'password',
          password_confirmation: 'password'
        }
    end
    
    it {
      expect(response).to have_http_status 200
    }

    it 'is expected to return a success message' do
      expect(response_json['status']).to eq 'Congratulations, you are now signed up!'
    end
  end

  context 'When a user submits' do
    describe 'a password confirmation that doesn\'t match password' do
      before do
        post '/api/auth',
        params: {
          name: 'Arthur',
          email: 'user@mail.com',
          password: 'password',
          password_confirmation: 'passsssword'
        }
      end

      it {
        expect(response).to have_http_status 422
      }

      it 'is expected to return an error message with 422 status' do
        expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
      end
    end

    describe 'an invalid email address' do
      before do
        post '/api/auth',
        params: {
          name: 'Arthur',
          email: 'user@mail',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it {
        expect(response).to have_http_status 422
      }

      it 'is expected to return an error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end
    end

    describe 'an already registered email' do
      let!(:registered_user) { create(:user)}

      before do
        post '/api/auth',
        params: {
          name: 'Hampus',
          email: 'user@mail.com',
          password: 'password',
          password_confirmation: 'passsword'
        }
      end

      it {
        expect(response).to have_http_status 422
      }

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end
    end
    
    describe 'an already registered name' do
      let!(:registered_user) { create(:user)}

      before do
        post '/api/auth',
        params: {
          name: 'Arthur',
          email: 'arthur@mail.com',
          password: 'password',
          password_confirmation: 'passsword'
        }
      end

      it {
        expect(response).to have_http_status 422
      }

      it 'returns an error message' do
        expect(response_json['errors']['name']).to eq ['has already been registered!']
      end
    end 
  end
end