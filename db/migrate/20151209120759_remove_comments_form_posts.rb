class RemoveCommentsFormPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :comments
  end
end
