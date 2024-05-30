class TeamBlueprint < Blueprinter::Base
    identifier :id
  
    view :teams_list do
      fields :name, :description, :employees_with_active_dates
    end

    view :teams_history do
      fields :name, :description, :employees_with_dates
    end
  end
  

