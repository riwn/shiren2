class Rank < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :recordimage, :string
  end
end
