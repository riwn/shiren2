class AddDungeonidToRanks < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :dungeon_id, :integer
  end
end
