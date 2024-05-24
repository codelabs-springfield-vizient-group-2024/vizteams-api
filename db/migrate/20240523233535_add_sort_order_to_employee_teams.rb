class AddSortOrderToEmployeeTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :employee_teams, :sort_order, :integer
  end
end
