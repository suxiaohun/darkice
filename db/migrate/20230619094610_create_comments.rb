class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: true
      t.text :content

      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
