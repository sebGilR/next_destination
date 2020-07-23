require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  describe 'Require login' do
    it 'Returns log in request if user is not logged in' do
      create_destination
      dest_id = Destination.last.id

      post_favorite(dest_id)
      expect(response.body).to include('Login required')

      favorites_setup
      post_favorite(dest_id)
      fav_id = Favorite.last.id
      log_out
      delete_favorite(fav_id)
      expect(response.body).to include('Login required')
    end
  end

  describe '#create' do
    it 'Returns bad_request if the destination id is invalid' do
      favorites_setup
      dest_id = 'wrong'

      post_favorite(dest_id)
      expect(response).to have_http_status(:bad_request)
    end

    it 'Creates favorites for current user' do
      favorites_setup
      dest_id = Destination.last.id

      post_favorite(dest_id)

      expect(response.body).to include(dest_id.to_s)
      expect(response).to have_http_status(:success)
    end
  end

  it 'Gets the curent user\'s favorites' do
    favorites_setup
    dest_id = Destination.last.id
    post_favorite(dest_id)

    favorites

    expect(JSON.parse(response.body)['favorites'].length)
      .to eq(User.last.favorites.length)
    expect(response).to have_http_status(:success)
  end

  it 'Deletes a favorite destination for the current user' do
    favorites_setup
    dest_id = Destination.last.id
    post_favorite(dest_id)
    fav_id = Favorite.last.id
    expect { delete_favorite(fav_id) }.to change { Favorite.count }.by(-1)
    expect(response).to have_http_status(:success)
  end
end
