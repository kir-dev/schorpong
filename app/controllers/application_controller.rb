class ApplicationController < ActionController::Base
  include ApplicationHelper

  def require_login
    unless session[:user_id] || ENV['NONAUTH']
      session[:redirect_url] = request.original_fullpath
      redirect_to login_path
    end
  end

  def current_user
    if ENV['NONAUTH']
      return impersonate_user
    end
    @current_user ||= User.includes([ { memberships: [ :team ] } ]).find(session[:user_id])
  end
  helper_method :current_user
end
