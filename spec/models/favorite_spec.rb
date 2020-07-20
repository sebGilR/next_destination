require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it 'Returns false if the favorite already existed for the destination' do
    create_destination
    create_consumer_user
    destId = Destination.last.id
    Favorite.create(user_id: User.last.id, destination_id: destId)

    fav = Favorite.new(user_id: User.last.id, destination_id: destId)
    expect(fav.save).to be(false)
  end

  it 'Returns true if favorite didn\'t exist' do
    create_destination
    create_consumer_user
    destId = Destination.last.id

    fav = Favorite.new(user_id: User.last.id, destination_id: destId)
    expect(fav.save).to be(true)
  end
end
