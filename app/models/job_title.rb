class JobTitle < ApplicationRecord
    # Validations
    validates :title, presence: true

    # Associations
    has_many :employees
end
