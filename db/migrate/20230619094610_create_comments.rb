class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: true
      t.text :content

      t.integer :created_by
      t.string :created_by_name
      t.integer :updated_by
      t.string :updated_by_name
      t.timestamps
    end
  end
end
