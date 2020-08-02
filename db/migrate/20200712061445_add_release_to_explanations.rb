class AddReleaseToExplanations < ActiveRecord::Migration[5.2]
  def change
    add_column :explanations, :release, :boolean, default: false
  end
end
