class ApplicationController < ActionController::Base
  include ApplicationHelper

  def require_login
    unless session[:user_id]
      session[:redirect_url] = request.original_fullpath
      redirect_to login_path
    end
  end

  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def current_user
    @current_user ||= User.includes([ { memberships: [ :team ] } ]).find(session[:user_id])
  end
  helper_method :current_user
end
