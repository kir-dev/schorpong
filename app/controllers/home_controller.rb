class HomeController < ApplicationController
  def index
    if cookies.permanent[:visited]
      redirect_to '/articles'
    else
      cookies.permanent[:visited] = true
      @articles = Article.order(created_at: :desc).all
      render 'articles/index'
    end
  end

end
