class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.text :image_url
      t.string :title
      t.text :link

      t.timestamps
    end
  end
end
