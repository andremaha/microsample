class UsersController < ApplicationController
  
  def show
    @options = { size: 150 }
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user  = User.new
    @title = 'Sign up'
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
end
