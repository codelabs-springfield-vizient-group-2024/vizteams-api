class AddForeignKeyConstraintToEmployeeTeams < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :employee_teams, :teams, on_delete: :cascade
  end
end
