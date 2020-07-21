require 'rails_helper'

RSpec.describe Destination, type: :model do
  it 'Returns true if valid information is provided' do
    dest = Destination.new(name: 'San Francisco',
                           description: 'A long description',
                           img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')

    expect(dest.save).to be(true)
  end

  it 'Returns false if the name is not provided' do
    dest = Destination.new(description: 'A long description',
                           img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')

    expect(dest.save).to be(false)
  end

  it 'Returns false if the name is too long' do
    dest = Destination.new(name: `San Francisco San Francisco San Francisco San Francisco San Francisco
      San Francisco San Francisco San Francisco San Francisco San Francisco`,
                           description: 'A long description',
                           img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')

    expect(dest.save).to be(false)
  end

  it 'Returns false if the description is not present' do
    dest = Destination.new(name: 'San Francisco',
                           img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')

    expect(dest.save).to be(false)
  end

  it 'Returns false if the img_url is not present' do
    dest = Destination.new(name: 'San Francisco',
                           description: 'A long description')

    expect(dest.save).to be(false)
  end

  it 'Returns false if the img_url is not an allowed format' do
    dest = Destination.new(name: 'San Francisco',
                           description: 'A long description',
                           img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240')

    expect(dest.save).to be(false)
  end

  it 'Returns ordered by most favorites' do
    Destination.create(name: 'San Francisco',
                       description: 'A long description',
                       img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')

    Destination.create(name: 'Miami',
                       description: 'A long description',
                       img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')

    create_consumer_user
    dest_id = Destination.last.id
    Favorite.create(user_id: User.last.id, destination_id: dest_id)

    expect(Destination.order_by_most_favorites.first.name).to eq('Miami')
  end
end
