class AddDescriptionToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :description, :string
  end
end
