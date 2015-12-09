class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id, index: true, foreign_key: true
      t.text :content
      t.integer :likes
      t.text :comments

      t.timestamps null: false
    end
  end
end
