class CreateEmployeeTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_teams do |t|
      t.date :start_date
      t.date :end_date
      t.references :employee, null: false
      t.references :team, null: false, foreign_key: { on_delete: :nullify }

      t.timestamps
    end
  end
end
