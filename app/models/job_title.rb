class JobTitle < ApplicationRecord
validates :title, presence: true

    has_many :employees
end
