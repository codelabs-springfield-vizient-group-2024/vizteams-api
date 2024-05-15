class ChangeEmployeeTeamsForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :employee_teams, :teams
    add_foreign_key :employee_teams, :teams, on_delete: :nullify
  end
end
