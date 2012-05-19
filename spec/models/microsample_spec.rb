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
  
  describe "from_users_followed_by" do
    
    let(:user)        { FactoryGirl.create(:user) }
    let(:other_user)  { FactoryGirl.create(:user) }
    let(:third_user)  { FactoryGirl.create(:user) }
    
    before { user.follow!(other_user) }
    
    let(:own_post)        { user.microsamples.create!(content: "foo") }
    let(:followed_post)   { other_user.microsamples.create!(content: "bar") }
    let(:unfollowed_post) { third_user.microsamples.create!(content: "baz") }
    
    subject { Microsample.from_users_followed_by(user) }
    
    it { should include(own_post) }
    it { should include(followed_post) }
    it { should_not include(unfollowed_post) }
  end
end

