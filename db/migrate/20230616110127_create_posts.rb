class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content

      t.integer :created_by
      t.string :created_by_name
      t.integer :updated_by
      t.string :updated_by_name
      t.timestamps
    end
  end
end
