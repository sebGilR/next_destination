# User concern created to keep current user
module UserConcern
  extend ActiveSupport::Concern

  def require_login
    current_user
    return if @current_user

    render json: { status: :unauthorized, message: 'Login required' }
  end

  def require_admin
    current_user
    head :unauthorized unless @current_user.admin
  end

  private

  def current_user
    return @current_user if @current_user

    @current_user = User.find_by(username: session[:username])
  rescue ActiveRecord::RecordNotFound
    head :unauthorized
  end
end
