class ChangeCountInLikes < ActiveRecord::Migration
  def change
    change_column :likes, :count, :integer, default: 0
  end
end
