class AddTotalLinesToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :total_lines, :integer, default: 0
  end
end
