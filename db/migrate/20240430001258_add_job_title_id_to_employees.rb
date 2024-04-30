class AddJobTitleIdToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_reference :employees, :job_title, null: false, foreign_key: true
  end
end
