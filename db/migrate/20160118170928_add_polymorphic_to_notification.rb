class AddPolymorphicToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :notifiable, index: true, polimorphic: true
  end
end
