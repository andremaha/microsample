class MicrosamplesController < ApplicationController
  before_filter :logged_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def create
    @microsample = current_user.microsamples.build(params[:microsample])
    if @microsample.save
      flash[:success] = "Microsample created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    current_user.microsamples.find_by_id(params[:id]).destroy
#    @microsample.destory
    redirect_back_or root_path
  end
  
  private 
  
    def correct_user
      @microsample = current_user.microsamples.find_by_id(params[:id])
      redirect_to root_path if @microsample.nil?
    end
end