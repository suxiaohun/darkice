class CreateGbServices < ActiveRecord::Migration[7.1]
  def change
    create_table :gb_services do |t|
      t.string :name
      t.string :version
      t.string :tag

      t.timestamps
    end
  end
end
