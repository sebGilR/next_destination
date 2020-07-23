if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_nextdest_app", domain: "next-destination.herokuapp.com/" #app back end
else
  Rails.application.config.session_store :cookie_store, key: "_nextdest_app"
end   