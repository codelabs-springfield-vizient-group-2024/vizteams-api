class Employee < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    has_many :employee_teams
    belongs_to :job_title
   
    has_many   :teams, through: :employee_teams
   
end
