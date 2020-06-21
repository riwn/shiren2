class CreateDungeons < ActiveRecord::Migration[5.2]
  def change
    create_table :dungeons do |t|
      t.string :name
      t.integer :cuttime
      t.text :regulation
      t.string :uriname
      t.string :dungeoncolor

      t.timestamps
    end
  end
end
