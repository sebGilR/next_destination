require 'rails_helper'

RSpec.describe 'Destinations', type: :request do
  describe 'Require login' do
    it 'returns log in request if the user is not logged in' do
      create_consumer_user

      post_destination
      expect(response.body).to include('Login required')

      create_destination
      dest_id = Destination.last.id
      put_destination(dest_id)
      expect(response.body).to include('Login required')

      delete_destination(dest_id)
      expect(response.body).to include('Login required')
    end
  end

  context 'Consumer tasks' do
    it 'Gets an array with destinations' do
      create_consumer_user
      log_in
      destinations

      expect(JSON.parse(response.body)['destinations'].length).to eq(Destination.count)
      expect(response).to have_http_status(:success)
    end

    it 'Gets an specific destination' do
      create_destination
      dest_id = Destination.last.id

      create_consumer_user
      log_in
      get_destination(dest_id)

      expect(response.body).to include('San Francisco')
      expect(response).to have_http_status(:success)
    end
  end

  context 'User is admin' do
    it 'Creates a new destination' do
      create_admin_user
      log_in_admin
      post_destination

      expect(response.body).to include('San Francisco')
      expect(response).to have_http_status(:success)
    end

    it 'Updates a destination' do
      create_admin_user
      log_in_admin
      post_destination
      dest_id = Destination.last.id

      expect(response.body).to include('A long description')

      put_destination(dest_id)

      expect(Destination.last.description).to eq('A new description')
      expect(response).to have_http_status(:success)
    end

    it 'Destroys a destination' do
      create_admin_user
      log_in_admin
      post_destination
      dest_id = Destination.last.id

      expect { delete_destination(dest_id) }.to change { Destination.count }.by(-1)
      expect(response).to have_http_status(:success)
    end
  end

  context 'Consumer user' do
    it 'Not authorized to create a new destination' do
      create_consumer_user
      log_in
      post_destination

      expect(response).to have_http_status(:unauthorized)
    end

    it 'Not authorized to update or delete a destination' do
      create_destination
      dest_id = Destination.last.id

      create_consumer_user
      log_in

      put_destination(dest_id)
      delete_destination(dest_id)

      expect(Destination.last.description).to eq('A long description')
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
