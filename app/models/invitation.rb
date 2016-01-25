class Invitation < ActiveRecord::Base
  include Notifiable

  after_update :create_friendship

  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  private

  def create_friendship
    if self.approved_changed? && self.approved == true
      Friendship.create!(user: self.from_user, friend: self.to_user)
    end
  end
end
