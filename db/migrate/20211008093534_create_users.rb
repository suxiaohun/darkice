class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :uuid, limit: 32, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false
      t.integer :state, null: false

      t.timestamps
    end
  end
end
