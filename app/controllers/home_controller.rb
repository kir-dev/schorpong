class HomeController < ApplicationController
  def index
    if current_user.nil? || current_user.animation_enabled?
      @articles = Article.order(created_at: :desc).all
      render 'articles/index'
    else
      redirect_to '/articles'
    end
  end
end
