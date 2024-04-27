class Employee < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
  

    belongs_to :job_title
    belings_to :team
end
