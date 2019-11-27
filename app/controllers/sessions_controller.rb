class SessionsController < ApplicationController

  def new
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def create
    raw_user = request.env['omniauth.auth']['extra']['raw_info']
    redirect_url = session[:redirect_url] || root_path
    user = User.find_by(auth_sch_id: raw_user['internal_id'])
    if user
      session[:user_id] = user.id
      redirect_to redirect_url
    else
      oauth_data = raw_user
      oauth_params = {
          auth_sch_id: oauth_data["internal_id"],
          mail: oauth_data["mail"],
          name: oauth_data["displayName"]
      }
      @user = User.create(oauth_params)
      if @user.valid?
        session[:user_id] = @user.id
        session.delete(:oauth_data)
        redirect_to root_url
      else
        render :new
      end
    end
  end

  def create_for_registered
    @user = User.find_by(mail: params[:mail])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to root_url
    else
      flash[:notice] = 'Sikertelen bejelentkezés! :('
      redirect_to sign_in_path
    end
  end
end
