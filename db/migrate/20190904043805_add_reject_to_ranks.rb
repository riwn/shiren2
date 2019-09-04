class AddRejectToRanks < ActiveRecord::Migration[5.2]
  def change
    add_column :ranks, :rejection, :boolean, default: false
    add_column :ranks, :rejectioncomment, :text
  end
end
