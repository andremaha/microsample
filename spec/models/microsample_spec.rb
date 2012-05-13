# == Schema Information
#
# Table name: microsamples
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
require 'spec_helper'

describe Microsample do
  
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    @microsample = user.microsamples.build(content: "Lorem ipsum")
  end
  
  subject { @microsample }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @microsample.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Microsample.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "with blank content" do
    before { @microsample.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @microsample.content = "a" * 141 }
    it { should_not be_valid }
  end
end

