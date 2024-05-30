class Team < ApplicationRecord


    scope :active, -> { where(is_deleted: false) }
    # Validations
    validates :name, presence: true
  
    # Associations
    has_many :employee_teams
    has_many :employees, through: :employee_teams

    accepts_nested_attributes_for :employee_teams, allow_destroy: true

    # Access start_date and end_date for team employees
    def employees_with_dates
        employee_teams.order(:sort_order).includes(:employee).map do |employee_team|
            employee_hash = EmployeeBlueprint.render_as_hash(employee_team.employee)
            employee_hash[:start_date] = employee_team.start_date
            employee_hash[:end_date] = employee_team.end_date
            employee_hash
        end
    end

    # Access active team employees
    def employees_with_active_dates
        employee_teams.where(end_date: nil).order(:sort_order).includes(:employee).map do |employee_team|
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
