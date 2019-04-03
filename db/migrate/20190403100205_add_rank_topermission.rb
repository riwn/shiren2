class AddRankTopermission < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :permission, :integer
  end
end
