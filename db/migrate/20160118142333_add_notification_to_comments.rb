class AddNotificationToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :notification, index: true, foreign_key: true
  end
end
