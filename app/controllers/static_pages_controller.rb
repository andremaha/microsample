class StaticPagesController < ApplicationController
  
  def home
    @microsample = current_user.microsamples.build if logged_in?
    if current_user.nil?
      @feed_items = []
    else
      @feed_items  = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
    @title = 'Help'
  end

  def contact
    @title = 'Contact'
  end
  
  def about
    @title = 'About'
  end
end
