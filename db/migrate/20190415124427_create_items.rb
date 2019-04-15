class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :name
      t.text :type
      t.integer :buy
      t.integer :sell
      t.integer :buydif
      t.integer :selldif
      t.integer :mincnt
      t.integer :maxcnt

      t.timestamps
    end
  end
end
