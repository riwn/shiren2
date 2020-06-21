class AddColumnDisplayToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :banners, :display_by, :datetime
  end
end
