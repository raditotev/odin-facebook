class RemoveNotificationFromComents < ActiveRecord::Migration
  def change
    remove_column :comments, :notification_id
  end
end
