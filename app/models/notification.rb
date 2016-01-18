class Notification < ActiveRecord::Base
  belongs_to :user

  has_many :likes
  has_many :comments
  has_many :requests, class_name: "Invitation"
end
