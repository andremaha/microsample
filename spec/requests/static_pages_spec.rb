require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "MicroSample" }
  
  describe "Home page" do
    it "should have a content 'MicroSample'" do
    	visit '/static_pages/home'
	page.should have_content('MicroSample')
    end
    it "should have a title 'Home'" do
    	visit '/static_pages/home'
	page.should have_selector('title', 
				:text => "#{base_title} | Home")
    end
  end

  describe "Help page" do
    it "should have a content 'Help'" do
        visit '/static_pages/help'
	page.should have_content('Help')
    end
    it "should have a title 'Help'" do
	visit '/static_pages/help'     
	page.should have_selector('title', 
				:text => "#{base_title} | Help")
    end
  end

  describe "Contact page" do
    it "should have a content 'Contact'" do
        visit '/static_pages/contact'
	page.should have_content('Contact')
    end
    it "should have a title 'Title'" do
        visit '/static_pages/contact'
	page.should have_selector('title',
				:text => "#{base_title} | Contact")
    end
  end

end
