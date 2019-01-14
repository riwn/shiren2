class ChangeDatatypeResultOfRank < ActiveRecord::Migration[5.2]
  def change
    change_column :ranks, :result, :integer
  end
end
