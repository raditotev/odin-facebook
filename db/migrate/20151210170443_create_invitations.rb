class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :from_user_id, index: true, foreign_key: true
      t.integer :to_user_id, index: true, foreign_key: true
      t.boolean :approved, default: false
    end
  end
end
