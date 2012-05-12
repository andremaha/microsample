class SessionsController < ApplicationController
  
  def new
    @title = 'Log in'
  end
  
  def create
    @title = 'Log in'
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
