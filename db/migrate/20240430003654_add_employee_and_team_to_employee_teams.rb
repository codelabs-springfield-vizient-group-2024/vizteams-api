class AddEmployeeAndTeamToEmployeeTeams < ActiveRecord::Migration[7.1]
  def change
    add_reference :employee_teams, :employee, null: false, foreign_key: true
    add_reference :employee_teams, :team, null: false, foreign_key: true
  end
end
