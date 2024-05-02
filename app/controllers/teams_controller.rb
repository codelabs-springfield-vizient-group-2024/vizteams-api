class TeamsController < ApplicationController
    before_action :set_team, only: [:show, :update, :destroy]
    
    # GET /teams
    def index
        teams = Team.all
        render json: teams, status: :ok
    end
    
    # GET /teams/:id
    def show
        render json: @current_team, status: :ok
    end

    def team_emp
      emp_teams=@current_team.employees
      if emp_teams>0
        render json: emp_teams,status: :ok
      else
        render json: {'error':"No member on the team"}
      end
    

      
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
  
    private

    def set_team
        @current_team = Team.find(params[:id])
    end
  
    def team_params
      params.permit(:name)
    end
  
end
