class EmployeeTeam < ApplicationRecord
    belongs_to :employees
    belongs_to :team
end
