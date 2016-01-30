class Comment < ActiveRecord::Base
  validates :content, presence: true
  include Notifiable

  belongs_to :post
  belongs_to :user
end
