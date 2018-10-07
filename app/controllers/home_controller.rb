class HomeController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

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
