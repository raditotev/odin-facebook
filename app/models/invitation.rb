class Invitation < ActiveRecord::Base
  include Notifiable

  after_update :create_friendship

  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  private

  def create_friendship
    if self.approved_changed? && self.approved == true
      Friendship.create!(user: from_user, friend: to_user)
    end
  end
end
