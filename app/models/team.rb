class Team < ApplicationRecord
    validates :name, presence: true
  



    has_many :employees, through: :employee_team

end
