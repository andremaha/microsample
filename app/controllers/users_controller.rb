class UsersController < ApplicationController
  before_filter :logged_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def index
    @title = 'Our wonderful users'
    @users = User.paginate(page: params[:page])
  end
  
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
      flash[:success] = "Welcome to MicroSamplt!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      log_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed =("
    redirect_to users_path
  end
  
  private
  
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_path, notice: "Please log in"
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, notice: "Looks like you are trying to access the page that does not belong to you. Please play nicely!") unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
