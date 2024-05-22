class Team < ApplicationRecord


    scope :active, -> { where(is_deleted: false) }
    # Validations
    validates :name, presence: true
  
    # Associations
    has_many :employee_teams
    # has_many :employees, through: :employee_teams
    has_many :employees
    

    # Access start_date and end_date for team employees
    def employees_with_dates
        employee_teams.includes(:employee).map do |employee_team|
            employee_hash = EmployeeBlueprint.render_as_hash(employee_team.employee)
            employee_hash[:start_date] = employee_team.start_date
            employee_hash[:end_date] = employee_team.end_date
            employee_hash
        end
    end
    def soft_delete
        update(is_deleted: true)
    end
end
