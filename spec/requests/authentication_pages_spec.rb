require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "login page" do
    before { visit login_path }
    
    it { should have_selector('h1', text: 'Log in') }
    it { should have_selector('title', text: 'Log in') }
  end
  
  describe "login action" do
    before { visit login_path }
    
    describe "with invalid information" do
      before { click_button "Log in" }
      
      it { should have_selector('title', text: 'Log in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end   
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { log_in user }
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Log out', href: logout_path) }
      it { should_not have_link('Log in', href: login_path) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Users', href: users_path )}
      
      describe "followed by logout" do 
        before { click_link "Log out" }
        it { should have_link('Log in')}
      end
    end
  end
  
  describe "authorization" do
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { log_in non_admin }
      
      describe "submitting a DELETE request to the Users#descroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end
      
    end
    
    describe "for non-logged-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
        end
        
        describe "after login in" do
          it "should render the protected page - edit the current user" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end
      
      describe "in the Microsamples controller" do 
        
        describe "submitting to the create action" do
          before { post microsamples_path }
          specify { response.should redirect_to(login_path) }
        end
        
        describe "submitting to the destroy action" do
          before do 
            microsample = FactoryGirl.create(:microsample)
            delete microsample_path(microsample)
          end
          specify { response.should redirect_to(login_path) }
        end
        
      end
      
      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Log in') }
        end
        
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(login_path) }
        end
        
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Log in') }
        end
        
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { log_in user }
      
      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
        it { should have_selector('div.alert.alert-notice', text: 'play nicely!')}
      end
      
      describe "submitting a PUT request to the Users#update action" do 
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
