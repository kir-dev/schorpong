# frozen_string_literal: true

class RegistrationController < ApplicationController
  def new
    @registration = User.new
  end

  def create
    @registration = User.new(registration_params)
    if !registration_params[:password].eql?(registration_params[:password_confirmation])
      flash[:notice] = 'A jelszavak nem egyeznek!'
      render new_registration_path
    elsif @registration.save
      flash[:notice] = 'Sikeres regisztráció!'
      redirect_to '/'
    else
      flash[:notice] = @registration.errors.full_messages.join(', ')
      render new_registration_path
    end
  end

  def registration_params
    params.require(:registration).permit(:name, :mail, :password, :password_confirmation)
  end
end
