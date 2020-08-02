class CreateExplanations < ActiveRecord::Migration[5.2]
  def change
    create_table :explanations do |t|
      t.string :title
      t.integer :dungeon_id
      t.integer :section
      t.text :content

      t.timestamps
    end
  end
end
