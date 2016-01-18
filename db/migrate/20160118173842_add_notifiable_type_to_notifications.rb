class AddNotifiableTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :notifiable_type, :string
    add_index :notifications, [:notifiable_id, :notifiable_type], unique: true
  end
end
