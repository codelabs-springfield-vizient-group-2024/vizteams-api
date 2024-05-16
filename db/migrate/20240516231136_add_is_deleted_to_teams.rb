class AddIsDeletedToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :is_deleted, :boolean, default: false
  end
end
