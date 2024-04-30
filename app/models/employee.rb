class Employee < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
  

    belongs_to :job_title
    has_many :teams, through: :employee_team
end
