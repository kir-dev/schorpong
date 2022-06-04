require 'bcrypt'

class SessionWithEmailController < ApplicationController
  class LoginError < StandardError; end

  def login_page
    @user = User.new
  end

  def login
    @current_user = User.find_by(mail: params[:user][:mail])
    raise LoginError if @current_user.nil? || @current_user.auth_sch_id.present?
    password = BCrypt::Password.new(@current_user.password)
    raise LoginError unless password == params[:user][:password]
    session[:user_id] = @current_user.id
    redirect_to root_path
  rescue LoginError
    @user = User.new(login_params)
    flash[:notice] = "Hibás adatok!"
    render 'login_page'
  end

  def registration_page
    @user = User.new
  end

  def registration
    @user = User.new(registration_params)

    unless (params[:user][:password] == params[:user][:confirmation])
      flash[:notice] = "Jelszavak nem egyeznek"
      return render "registration_page"
    end
    return render "registration_page" unless @user.valid?
    @user.password = BCrypt::Password.create(@user.password)

    if (@user.save)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user.password = nil
      render :email_registration_new
    end
  end

  private

  def registration_params
    params.require(:user).permit(:mail, :password, :name)
  end

  def login_params
    params.require(:user).permit(:mail, :password)
  end
end
