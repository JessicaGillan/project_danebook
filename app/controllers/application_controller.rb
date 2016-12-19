class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # force_ssl # TODO: this blocks local host, how to fix?

  before_action :require_logged_in

  private

  def require_logged_in
    unless user_logged_in?
      flash[:error] = "You must sign in."
      store_location
      redirect_to login_path
    end
  end

  def log_in(user)
    user.regenerate_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_log_in(user)
    user.regenerate_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def log_out
    @current_user.auth_token = nil
    @current_user = nil
    cookies[:auth_token] = nil
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def user_logged_in?
    !!current_user
  end
  helper_method :user_logged_in?

  def is_current_user?(user)
    user_logged_in? && ( current_user.id == user.id )
  end
  helper_method :is_current_user?

  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
