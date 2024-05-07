class TeamsController < ApplicationController
    before_action :set_team, only: [:show, :update, :destroy]
    
    # GET /teams
    def index
        teams = Team.all
        render json: TeamBlueprint.render(teams, view: :teams_list), status: :ok
    end
    
    # GET /teams/:id
    def show
        render json: TeamBlueprint.render(@current_team, view: :teams_list), status: :ok
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
