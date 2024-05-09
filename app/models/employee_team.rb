class EmployeeTeam < ApplicationRecord
    # Associations
    belongs_to :employee
    belongs_to :team
end
