class Employee < ApplicationRecord
    # Validations
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    # Associations
    belongs_to :job_title
    has_many :employee_teams
    has_many :teams, through: :employee_teams
    has_one_attached :image
end
