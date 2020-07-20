require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe 'Require login' do
    it 'Returns log in request if user is not logged in' do
      create_destination
      destId = Destination.last.id

      post_favorite(destId)
      expect(response.body).to include('Login required')

      favorites_setup
      post_favorite(destId)
      favId = Favorite.last.id
      log_out
      delete_favorite(favId)
      expect(response.body).to include('Login required')
    end
  end

  describe '#create' do
    it 'Returns bad_request if the destination id is invalid' do
      favorites_setup
      destId = 'wrong'
  
      post_favorite(destId)
      expect(response).to have_http_status(:bad_request)
    end

    it 'Creates favorites for current user' do
      favorites_setup
      destId = Destination.last.id
  
      post_favorite(destId)
  
      expect(response.body).to include(destId.to_s)
      expect(response).to have_http_status(:success)
    end    
  end

  it 'Gets the curent user\'s favorites' do
    favorites_setup
    destId = Destination.last.id
    post_favorite(destId)

    get_favorites

    expect(JSON.parse(response.body)['favorites'].length)
      .to eq(User.last.favorites.length)
    expect(response).to have_http_status(:success)
  end

  it 'Deletes a favorite destination for the current user' do
    favorites_setup
    destId = Destination.last.id
    post_favorite(destId)
    favId = Favorite.last.id
    expect { delete_favorite(favId) }.to change { Favorite.count }.by(-1)
    expect(response).to have_http_status(:success)
  end
end
