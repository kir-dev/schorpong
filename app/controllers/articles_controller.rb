class ArticlesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.order(created_at: :desc).all
    byebug
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Hír sikeresen létrehozva.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Hír sikeresen frissítve.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Hír sikeresen törölve.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :image, :intro, :content)
    end
end
