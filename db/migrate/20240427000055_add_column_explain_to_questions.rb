class AddColumnExplainToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions,:explain,:string
  end
end
