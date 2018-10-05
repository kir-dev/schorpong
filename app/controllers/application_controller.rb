class ApplicationController < ActionController::Base
  include ApplicationHelper

  def require_login
    unless logged_in?
      session[:redirect_url] = request.original_fullpath
      redirect_to root_url
    end
  end

  def require_admin
    redirect_to root_url unless logged_in? && current_user.admin?
  end

  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def current_user
    @current_user ||= User.includes([ { memberships: [ :team ] } ]).find(session[:user_id]) if logged_in?
  end
  helper_method :current_user
end
