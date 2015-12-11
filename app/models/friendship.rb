class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :ensure_reverse_friendship

  private

  def ensure_reverse_friendship
    unless Friendship.exists?(user: self.friend, friend: self.user)
      Friendship.create(user: self.friend, friend: self.user)
    end
  end
end
