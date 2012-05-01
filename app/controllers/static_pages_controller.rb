class StaticPagesController < ApplicationController
  def home
    @title = 'Home'
  end

  def help
    @title = 'Help'
  end

  def contact
    @title = 'Contact'
  end
end
