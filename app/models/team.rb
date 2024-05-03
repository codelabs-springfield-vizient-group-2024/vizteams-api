class Team < ApplicationRecord
    # Validations
    validates :name, presence: true
  
    # Associations
    has_many :employee_teams
    has_many :employees, through: :employee_teams
end
