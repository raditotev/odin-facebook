class AddNotificationToLikes < ActiveRecord::Migration
  def change
    add_reference :likes, :notification, index: true, foreign_key: true
  end
end
