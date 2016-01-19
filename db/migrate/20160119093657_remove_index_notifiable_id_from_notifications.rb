class RemoveIndexNotifiableIdFromNotifications < ActiveRecord::Migration
  def change
    remove_index :notifications, column: :notifiable_id
  end
end
