class CreateFileIndices < ActiveRecord::Migration[7.1]
  def change
    create_table :file_indices do |t|
      t.integer :file_id
      t.integer :lineno
      t.integer :position
      t.index [:file_id, :lineno]

      t.timestamps
    end
  end
end
