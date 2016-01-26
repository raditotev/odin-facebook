class Notification < ActiveRecord::Base
  belongs_to :user

  belongs_to :notifiable, polymorphic: true
  validates :user, presence: true
end
