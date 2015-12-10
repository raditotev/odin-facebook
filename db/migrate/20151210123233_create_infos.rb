class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.references :user, index: true, foreign_key: true
      t.date :birthday
      t.string :work
      t.string :education
      t.string :address
      t.string :phone
      t.text :about

      t.timestamps null: false
    end
  end
end
