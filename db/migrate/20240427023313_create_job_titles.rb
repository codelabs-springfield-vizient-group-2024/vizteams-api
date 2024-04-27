class CreateJobTitles < ActiveRecord::Migration[7.1]
  def change
    create_table :job_titles do |t|
      t.string :title

      t.timestamps
    end
  end
end
