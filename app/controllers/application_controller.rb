class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_strava_user!
  before_action :redirect_to_previous_attempted_url

  private

  def authenticate_strava_user!
    unless current_user
      if request.get?
        store_attempted_url
      end
      redirect_to user_omniauth_authorize_path(provider: :strava)
    end
  end

  def redirect_to_previous_attempted_url
    if path = session.delete(:user_return_to).presence
      redirect_to path
    end
  end

  def store_attempted_url
    session[:user_return_to] = request.original_fullpath
  end
end
