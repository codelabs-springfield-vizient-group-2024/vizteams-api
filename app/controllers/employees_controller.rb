class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :update, :destroy]
    
    # GET /employees
    def index
        employees = Employee.all
        render json: employees, status: :ok
    end

    # GET teams/:id/employees
    def team_employees
        team = Team.find(params[:id])
        render json: team.employees, status: :ok
    end
    
    # GET /employees/:id
    def show
        render json: @current_employee, status: :ok
    end

    # POST /employees
    def create
      employee = Employee.new(employee_params.except(:team_id))
      
      if employee_params[:profile_image].present?
        employee.profile_image.attach(employee_params[:profile_image])
      end

      if employee.save
        team = Team.find(employee_params[:team_id])
        employee_team = EmployeeTeam.new(employee: employee, team: team)

        if employee_team.save
          render json: employee, status: :created
        else
          render json: employee_team.errors, status: :unprocessable_entity
        end

      else
        render json: employee.errors, status: :unprocessable_entity
      end
    end
    
    # PUT /employees/:id
    # def update
    #   if @current_employee.update(employee_params)
    #     render json: @current_employee, status: :ok
    #   else
    #     render json: @current_employee.errors, status: :unprocessable_entity
    #   end
    # end
  
    # # DELETE /employees/:id
    # def destroy
    #   if @current_employee.destroy
    #     render json: nil, status: :ok
    #   else
    #     render json: @current_employee.errors, status: :unprocessable_entity
    #   end
    # end

    # def upload_image
    #     if @current_employee.image.attach(params[:profile_image])
    #       render json: { message: "Image uploaded" }, status: :ok
    #     else
    #       render json: { message: "Image upload failed" }, status: :unprocessable_entity
    #     end
    # end
    
    # def profile_image_url
    #   rails_blob_url(self.profile_image, only_path: false) if self.profile_image.attached?
    # end
    def update
      if @current_employee.update(employee_params.except(:profile_image))
        if employee_params[:profile_image].present?
          @current_employee.profile_image.attach(employee_params[:profile_image])
        end
        render json: @current_employee, status: :ok
      else
        render json: @current_employee.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /employees/:id
    def destroy
      if @current_employee.destroy
        render json: nil, status: :ok
      else
        render json: @current_employee.errors, status: :unprocessable_entity
      end
    end
  
    def upload_image
      if @current_employee.image.attach(params[:profile_image])
        render json: { message: "Image uploaded" }, status: :ok
      else
        render json: { message: "Image upload failed" }, status: :unprocessable_entity
      end
    end
    
    def profile_image_url
      rails_blob_url(self.profile_image, only_path: false) if self.profile_image.attached?
    end
    private

    def set_employee
        @current_employee = Employee.find(params[:id])
    end
  
    def employee_params
      params.permit(:first_name, :last_name, :profile_image, :job_title_id, :team_id)
    end
end
