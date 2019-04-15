class AdduseridToRank < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :user_id, :integer
  end
end
