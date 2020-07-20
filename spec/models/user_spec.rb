require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Returns true and the user is saved if information is valid' do
    user = User.new(username: 'userfortest',
                    password: '123456',
                    password_confirmation: '123456')
    expect(user.valid?).to be(true)
    expect(user.save).to be(true)
  end

  it 'Returns false if username is not provided' do
    user = User.new(username: 'us',
                    password: '123456',
                    password_confirmation: '123456')

    expect(user.valid?).to be(false)
  end

  it 'Returns false if username is too short' do
    user = User.new(password: '123456',
                    password_confirmation: '123456')

    expect(user.valid?).to be(false)
  end

  it 'Returns false if the user already exists' do
    create_consumer_user
    user = User.new(username: 'userfortest',
                password: '123456',
                password_confirmation: '123456')

    expect(user.valid?).to be(false)
  end

  it 'Returns false if the password is not provided' do
    user = User.new(username: 'userfortest')
    expect(user.valid?).to be(false)
  end

  it 'Returns false if the password is not confirmed' do
    user = User.new(username: 'userfortest',
                    password: '123456')
    expect(user.valid?).to be(false)
  end

  it 'Returns false if the password is too short' do
    user = User.new(username: 'userfortest',
                    password: '12',
                    password_confirmation: '12')
    expect(user.valid?).to be(false)
  end

  it 'Returns false if the passwords don\'t match' do
    user = User.new(username: 'userfortest',
                    password: '123456',
                    password_confirmation: '127654')
    expect(user.valid?).to be(false)
  end
end
