# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  
  identifier :id

  view :normal do
    fields :email, :first_name, :last_name
  end
end
