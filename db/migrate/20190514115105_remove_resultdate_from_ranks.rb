class RemoveResultdateFromRanks < ActiveRecord::Migration[5.2]
  def change
    remove_column :ranks, :resultdate, :date
  end
end
