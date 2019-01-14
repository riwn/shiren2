class RemoveRequestdateToRanks < ActiveRecord::Migration[5.2]
  def change
    remove_column :ranks, :requestdate, :datetime
  end
end
