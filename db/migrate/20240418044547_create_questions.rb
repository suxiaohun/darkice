class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :title
      t.text :options
      t.string :mode
      t.string :answer

      t.timestamps
    end
  end
end
