class RemoveNotificationFromLikesAndInvitations < ActiveRecord::Migration
  def change
    remove_column :likes, :notification_id
    remove_column :invitations, :notification_id
  end
end
