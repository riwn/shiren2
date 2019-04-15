class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.text :name
      t.text :eventdate
      t.text :organizer
      t.text :rule
      t.text :result

      t.timestamps
    end
  end
end
