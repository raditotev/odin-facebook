class Friendship < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :friend_id

  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :ensure_reverse_friendship
  after_destroy :destroy_reverse_friendship



  private

  def ensure_reverse_friendship
    unless Friendship.exists?(user: self.friend, friend: self.user)
      Friendship.create(user: self.friend, friend: self.user)
    end
  end

  def destroy_reverse_friendship
    if Friendship.exists?(user: self.friend, friend: self.user)
      Friendship.find_by(user: self.friend, friend: self.user).destroy
    end
  end
end
