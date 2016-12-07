class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    unless user_signed_in?
      flash[:danger] = "You must sign in."
      params[:forwarding_url] = request.referer
      redirect_to login_path
    end
  end

  def sign_in(user)
    user.regenerate_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    @current_user.nil
    cookies.delete(:auth_token)
    user.auth_token = nil
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def user_signed_in?
    !!current_user
  end

  helper_method :current_user
  helper_method :user_signed_in?
end
