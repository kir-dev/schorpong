class PagesController < ApplicationController
  before_action :require_admin, except: [:show]

  def show
    @page = Page.find_by(name: params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to root_url, notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :name, :content)
    end
end
