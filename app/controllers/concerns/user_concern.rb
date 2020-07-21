# User concern created to keep current user
module UserConcern
  extend ActiveSupport::Concern

  included do
    before_action :current_user
  end

  def current_user
    if session[:username]
      @current_user ||= User.find_by(username: session[:username])
    else
      @current_user = nil
    end
  end

  private

  def require_login
    return if @current_user

    render json: { status: :unauthorized, message: 'Login required' }
  end
end
