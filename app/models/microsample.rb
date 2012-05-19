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

class Microsample < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140, minimum: 1 }
  
  default_scope order: 'microsamples.created_at DESC'
  
  # Returns microsamples from the users being followed by the given user
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private 
  
    def self.followed_by(user)
      followed_user_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", { user_id: user })
    end
end
