class AddBeforeseasonToRanks < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :beforeseason, :boolean, default: false
  end
end
