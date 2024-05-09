# frozen_string_literal: true

class EmployeeBlueprint < Blueprinter::Base
  identifier :id
    
  fields :first_name, :last_name, :job_title, :profile_image_url
end
