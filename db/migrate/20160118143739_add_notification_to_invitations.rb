class AddNotificationToInvitations < ActiveRecord::Migration
  def change
    add_reference :invitations, :notification, index: true, foreign_key: true
  end
end
