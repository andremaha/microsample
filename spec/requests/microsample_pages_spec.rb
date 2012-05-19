require 'spec_helper'

describe "MicrosamplePages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { log_in user }
  
  
  describe "microsample creation" do
    before { visit root_path }
    
    describe "microsample destruction" do 
      before { FactoryGirl.create(:microsample, user: user) }

#      it "should delete a micropost" do
#        expect { click_link "delete" }.should change(Microsample, :count).by(-1)
#      end
    end
    
    describe "with invalid information" do
    
      it "should not create a microsample" do
        expect { click_button "Take a Sample"}.should_not change(Microsample, :count)
      end
    
      describe "error messages" do
        before { click_button "Take a Sample" }
        it { should have_content('error')} 
      end
    end
    
    describe "with valid information" do
      before { fill_in "microsample_content", with: "Lorem Impsum" }
      it "should create a microsample" do
        expect { click_button "Take a Sample"}.should change(Microsample, :count).by(1)
      end
    end
  end
end

