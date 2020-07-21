require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '#create' do
    it 'Creates a new user and returns its details' do
      sign_up_user

      expect(response.body).to include('userfortest')
      expect(response).to have_http_status(:success)
    end

    it 'Returns errors when invalid information is provided' do
      post '/api/v1/users', params: { username: 'userfortest',
                                      password: '123456' }

      expect(response.body).to include("can't be blank")
    end
  end
end
