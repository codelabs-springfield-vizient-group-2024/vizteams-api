class AddTeamRefToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_reference :employees, :team, null: true, foreign_key: true
  end
end
