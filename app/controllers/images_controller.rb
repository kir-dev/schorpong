class ImagesController < ApplicationController
  before_action :require_admin

  def create
    image_params[:image].open if image_params[:image].tempfile.closed?

    @image = Image.new(image_params)

    if @image.save
      render json: { url: @image.image_url }, status: :ok
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.require(:image).permit(:image)
  end
end
