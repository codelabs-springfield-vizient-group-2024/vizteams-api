# frozen_string_literal: true

class TeamBlueprint < Blueprinter::Base
    identifier :id

    view :teams_list do
        fields :name, :employees_with_dates
    end
end
