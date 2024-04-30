class AddTeamIdToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_reference :employees, :team, null: false, foreign_key: true
  end
end
