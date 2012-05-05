require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "MicroSample" }
  
  describe "Home page" do
    it "should have a content 'MicroSample'" do
    	visit '/static_pages/home'
	page.should have_content('MicroSample')
    end
    it "should have a base title 'MicroSample'" do
    	visit '/static_pages/home'
	page.should have_selector('title', 
				:text => "#{base_title}")
    end
    
    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
    
    it "should not have an empty body tag" do
      visit '/static_pages/home'
      page.should_not have_content(/\s*/)
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
    it "should have a title 'Contanct'" do
        visit '/static_pages/contact'
	page.should have_selector('title',
				:text => "#{base_title} | Contact")
    end
  end

end
