class TeamsController < ApplicationController
    before_action :set_team, only: [:show, :update, :destroy]
    
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
def team_emp
  team=Team.find(params[:id])
  emp_teams=team.employees
  emps=[]
  emp_teams.each do |emp|
    date=EmployeeTeam.where(employee_id:emp.id)
    emp_inf={
      "first_name":emp.first_name,
      'last_name':emp.last_name,
      'job':emp.job_title,
      'start_date':date.first.start_date,
      'end_date':date.first.end_date
    }
    emps.push(emp_inf)
    end
    render json: emps,status: :ok
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
  end





  
    private

    def set_team
        @current_team = Team.find(params[:id])
    end
  
    def team_params
      params.permit(:name,:description)
    end
  

