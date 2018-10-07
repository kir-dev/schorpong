class HomeController < ApplicationController
  def index
    if cookies.permanent[:visited]
      redirect_to '/articles'
    else
      cookies.permanent[:visited] = true
      @articles = Article.all
      render 'articles/index'
    end
  end

end
