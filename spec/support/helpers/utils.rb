module Utils
  def create_consumer_user
    User.create(username: 'userfortest',
                password: '123456',
                password_confirmation: '123456')
  end

  def create_admin_user
    User.create(username: 'adminfortest',
                password: '123456',
                password_confirmation: '123456',
                admin: true)
  end

  def create_destination
    Destination.create(name: 'San Francisco',
                       description: 'A long description',
                       img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg')
  end

  def log_in
    post '/api/v1/auth/login', params: { username: 'userfortest', password: '123456' }
  end

  def log_in_admin
    post '/api/v1/auth/login', params: { username: 'adminfortest', password: '123456' }
  end

  def log_out
    delete '/api/v1/auth/logout'
  end

  def sign_up_user
    post '/api/v1/users', params: { username: 'userfortest',
                                    password: '123456',
                                    password_confirmation: '123456' }
  end

  def connected?
    get '/api/v1/auth/connected'
  end

  def post_destination
    post '/api/v1/destinations', params: { name: 'San Francisco',
                                           description: 'A long description',
                                           img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg' }
  end

  def put_destination(id)
    put "/api/v1/destinations/#{id}",
        params: { name: 'San Francisco',
                  description: 'A new description',
                  img_url: 'https://s.hdnux.com/photos/01/12/72/67/19639794/3/920x1240.jpg' }
  end

  def delete_destination(id)
    delete "/api/v1/destinations/#{id}"
  end

  def destinations
    get '/api/v1/destinations'
  end

  def get_destination(id)
    get "/api/v1/destinations/#{id}"
  end

  def favorites
    get '/api/v1/favorites'
  end

  def post_favorite(id)
    post '/api/v1/favorites', params: { destination_id: id }
  end

  def delete_favorite(id)
    delete "/api/v1/favorites/#{id}"
  end

  def favorites_setup
    create_destination
    create_consumer_user
    log_in
  end
end
