class ChangePermissionToRank < ActiveRecord::Migration[5.2]
  def change
    change_column :ranks, :permission, :boolean, default: false
  end
end
