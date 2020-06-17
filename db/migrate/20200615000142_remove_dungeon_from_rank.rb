class RemoveDungeonFromRank < ActiveRecord::Migration[5.2]
  def change
    remove_column :ranks, :dungeon, :string
  end
end
