require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  describe "Home page" do   
    before { visit root_path }
    
    it { should have_content('MicroSamplt') }
    it { should have_selector('title', :text => full_title(nil)) }
    it { should_not have_selector('title', :text => '| Home') } 
    it { should_not have_content(/\s*/) }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:microsample, user: user, content: "Lorem imsum")
        FactoryGirl.create(:microsample, user: user, content: "Dolor sit amet")
        log_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end
    
    describe "for signed-in user with one microsample" do
      before do
        new_user = FactoryGirl.create(:user)
        FactoryGirl.create(:microsample, user: new_user, content: "This is the content of one microsample")
        log_in new_user
        visit root_path
      end
      
      it "should render the user's info in a sidebar" do   
        page.should have_selector('span', text: 'view my profile')
        page.should have_selector('span', text: '1 microsample')    
      end
    end
  end

  describe "Help page" do
    
    before { visit help_path }
    
    it { should have_content('Help') }       
    it { should have_selector('title', :text => full_title('Help')) }
  end

  describe "Contact page" do
    
    before { visit contact_path }
    
    it { should have_content('Contact') }
    it { should have_selector('title', :text => full_title('Contact')) }
  end
  
  describe "About page" do
    
    before { visit about_path }
    
    it { should have_content('About') }  
    it { should have_selector('title', :text => full_title('About')) }   
  end
  

end
