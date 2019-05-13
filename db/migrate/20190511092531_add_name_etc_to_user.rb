class AddNameEtcToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :icon, :string
    add_column :users, :niconico, :string
    add_column :users, :youtube, :string
    add_column :users, :cavetube, :string
    add_column :users, :twitch, :string
  end
end
