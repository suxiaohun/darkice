class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content

      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
