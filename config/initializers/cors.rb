Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins (Rails.env.production? ? 'https://feature-app.d1cjah403cwq78.amplifyapp.com/' : 'http://localhost:3000')

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end
