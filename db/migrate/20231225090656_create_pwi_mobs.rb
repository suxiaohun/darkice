class CreatePwiMobs < ActiveRecord::Migration[7.1]
  def change
    create_table :pwi_mobs do |t|
      t.string :name
      t.string :level
      t.string :life
      t.string :accuracy
      t.string :evasion
      t.string :physical_attack
      t.string :magic_attack
      t.string :physical_defense
      t.string :magic_defense
      t.string :speed

      t.timestamps
    end
  end
end
