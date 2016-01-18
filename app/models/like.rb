class Like < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :notification, as: :notifiable,
                    dependent: :destroy
end
