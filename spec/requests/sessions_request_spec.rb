require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe '#create' do
    it 'Logs in and returns the user' do
      create_consumer_user
      log_in
      expect(response.body).to include('userfortest')
      expect(response).to have_http_status(:success)
    end

    it 'Returns unauthorized if user info is incorrect' do
      create_consumer_user
      post '/api/v1/auth/login', params: {username: 'wronguser', password: '123456'}
      expect(response).to have_http_status(:unauthorized)
  
      post '/api/v1/auth/login', params: {username: 'userfortest', password: 'wrongpassword'}
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
  describe '#destroy' do
    it 'Logs the user out' do
      create_consumer_user
      log_in
      log_out
      expect(response).to have_http_status(:success)
    end
  end
  
  describe '#connected' do
    it 'Returns true and the user details if the user is logged in' do
      create_consumer_user
      log_in
      connected?
      expect(response.body).to include('true')
      expect(response.body).to include('userfortest')
      expect(response).to have_http_status(:success)
    end

    it 'Returns false if the user is not logged in' do
      create_consumer_user
      log_in
      connected?
      expect(response.body).to include('false')
      expect(response).to have_http_status(:success)
    end
  end
end
