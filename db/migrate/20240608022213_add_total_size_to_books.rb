class AddTotalSizeToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :total_size, :integer, default: 0
  end
end
