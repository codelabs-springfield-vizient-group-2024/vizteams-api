class RemoveTeamIdFromEmployees < ActiveRecord::Migration[7.1]
  def change
    remove_column :employees, :team_id, :integer
  end
end
