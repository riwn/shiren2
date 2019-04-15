class ChangeDefaultToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, null: false, default: ""
  end
end
