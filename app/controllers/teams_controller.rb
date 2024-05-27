class TeamsController < ApplicationController
    before_action :set_team, only: [:show, :update, :destroy,:rearrange_employees]
    
    # GET /teams
    def index
        teams = Team.active
        render json: TeamBlueprint.render(teams, view: :teams_list), status: :ok
    end
    
    # GET /teams/:id
    def show
        render json: TeamBlueprint.render(@current_team, view: :teams_list), status: :ok
    end
=begin
    def team_emp
      team=Team.find(params[:id])
      emp_teams=team.employees
      if emp_teams.length>0
        render json: emp_teams,status: :ok
      else
        render json: {'error':"No member on the team"}
      end      
    end
=end
# def team_emp
#   team = Team.find(params[:id])
#   emp_teams = team.employees.joins(:employee_teams).order('employee_teams.sort_order')

#   emps = []
#   emp_teams.each do |emp|
#     date = EmployeeTeam.where(employee_id: emp.id, end_date: nil)
#     next if date.length == 0

#     emp_inf = {
#       "first_name": emp.first_name,
#       'last_name': emp.last_name,
    
#       'job_title': emp.job_title,
#       'start_date': date.first.start_date,
#       'end_date': date.first.end_date
#     }
#     emps.push(emp_inf)
#   end

#   render json: emps, status: :ok
# end

def team_emp
  team = Team.find(params[:id])
  emp_teams = team.employee_teams.order(:sort_order).includes(employee: :job_title)

  emps = emp_teams.map do |emp_team|
    emp = emp_team.employee
 
    date = emp_team.end_date.nil? ? nil : { start_date: emp_team.start_date, end_date: emp_team.end_date }
    {
      id: emp.id,
      first_name: emp.first_name,
      last_name: emp.last_name,
      profile_image_url: emp.profile_image_url,
      job_title: emp.job_title, # Assign job_title here
      dates: date
    }
  end

  render json: emps.compact, status: :ok
end


    # POST /teams
    def create
      team = Team.new(team_params)
  
      if team.save
        render json: team, status: :created
      else
        render json: team.errors, status: :unprocessable_entity
      end
    end
    
    # PUT /teams/:id
    def update
      if @current_team.update(team_params)
        render json: @current_team, status: :ok
      else
        render json: @current_team.errors, status: :unprocessable_entity
      end
    end

    # def rearrange_employees
    #   @team = Team.find(params[:id])
    
    #   params[:employees_with_dates].each_with_index do |employee_params, index|
    #     employee_team = EmployeeTeam.find_by(team_id: @team.id, employee_id: employee_params[:id])
    #     if employee_team
    #       employee_team.update(
    #         start_date: employee_params[:start_date], 
    #         end_date: employee_params[:end_date], 
    #         sort_order: index + 1
    #       )
    #     else
    #       Rails.logger.warn "EmployeeTeam association not found for team_id: #{@team.id}, employee_id: #{employee_params[:id]}"
    #     end
    #   end
    
    #   @employees = @team.employees
    #                     .joins(:job_title, :employee_teams)
    #                     .select('employees.*, job_titles.title AS job_title_title, employee_teams.sort_order, employee_teams.start_date, employee_teams.end_date')
    #                     .order('employee_teams.sort_order')
    
    #   render json: @employees, status: :ok
    # end
    # def rearrange_employees
    #   @team = Team.find(params[:id])
      
    #   params[:employees_with_dates].each_with_index do |employee_params, index|
    #     employee_team = EmployeeTeam.find_by(team_id: @team.id, employee_id: employee_params[:id])
    #     if employee_team
    #       employee_team.update(
    #         start_date: employee_params[:start_date], 
    #         end_date: employee_params[:end_date], 
    #         sort_order: index + 1
    #       )
    #     else
    #       Rails.logger.warn "EmployeeTeam association not found for team_id: #{@team.id}, employee_id: #{employee_params[:id]}"
    #     end
    #   end
      
    #   # Fetch employees with job title included
    #   @employees = @team.employees
    #                     .joins(:job_title, :employee_teams)
    #                     .select('employees.*, job_titles.title AS job_title, employee_teams.sort_order, employee_teams.start_date, employee_teams.end_date')
    #                     .order('employee_teams.sort_order')
      
    #   render json: @employees, status: :ok
    # end
    
    def rearrange_employees
      @team = Team.find(params[:id])
      
      # Update the sort order and other details for each employee
      params[:employees_with_dates].each_with_index do |employee_params, index|
        employee_team = EmployeeTeam.find_by(team_id: @team.id, employee_id: employee_params[:id])
        if employee_team
          employee_team.update(
            start_date: employee_params[:start_date], 
            end_date: employee_params[:end_date], 
            sort_order: index + 1
          )
        else
          Rails.logger.warn "EmployeeTeam association not found for team_id: #{@team.id}, employee_id: #{employee_params[:id]}"
        end
      end
      
      # Fetch the updated list of employees with their job titles
      @employees = @team.employee_teams
                        .joins(employee: :job_title)
                        .select('employees.id, employees.first_name, employees.last_name,  job_titles.title AS job_title, employee_teams.start_date, employee_teams.end_date')
                        .order('employee_teams.sort_order')
      
      render json: @employees, status: :ok
    end
    
    



  
    # DELETE /teams/:id
    def destroy
      if @current_team.destroy
        render json: nil, status: :ok
      else
        render json: @current_team.errors, status: :unprocessable_entity
      end
    end
# SOFT DELETE
    def soft_delete
      @team = Team.find(params[:id])
      if @team.update(is_deleted: true)
        render json: @team, status: :ok
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end
  





  
    private

    def set_team
      @current_team = Team.find_by(id: params[:id])
      unless @current_team
        render json: { error: 'Team not found' }, status: :not_found
      end
    end
    
  
    def team_params
      params.require(:team).permit(:id, :name, :description, employees_with_dates: [ :first_name, :last_name, :profile_image_url, :start_date, :end_date])
    end
  end
  

