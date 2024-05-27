# frozen_string_literal: true

class EmployeeBlueprint < Blueprinter::Base
  identifier :id
   
  fields :first_name, :last_name, :profile_image_url
  view :normal do
    association :job_title, blueprint: JobTitleBlueprint, view: :normal
  end
end
