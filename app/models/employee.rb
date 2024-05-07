class Employee < ApplicationRecord
    include Rails.application.routes.url_helpers

    # Validations
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    # Associations
    belongs_to :job_title
    has_many :employee_teams
    has_many :teams, through: :employee_teams
    has_one_attached :profile_image

    def profile_image_url
        rails_blob_url(self.profile_image, only_path: false) if self.profile_image.attached?
    end
end
