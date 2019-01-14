class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.text :name
      t.text :dungeon
      t.time :result
      t.text :movie
      t.datetime :requestdate
      t.date :resultdate

      t.timestamps
    end
  end
end
