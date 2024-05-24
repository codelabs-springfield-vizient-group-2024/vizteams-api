class SetDefaultValueEmployeeTeamsStartDate < ActiveRecord::Migration[7.1]
  def change
    change_column_default :employee_teams, :start_date, -> { 'CURRENT_DATE' }
  end
end
