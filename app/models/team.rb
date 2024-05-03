class Team < ApplicationRecord
    # Validations
    validates :name, presence: true
  
    # Associations
    has_many :employee_teams
    has_many :employees, through: :employee_teams

    # Access start_date and end_date for team employees
    def employees_with_dates
        employee_teams.includes(:employee).map do |employee_team|
          {
            employee: employee_team.employee,
            start_date: employee_team.start_date,
            end_date: employee_team.end_date
          }
        end
    end
end
