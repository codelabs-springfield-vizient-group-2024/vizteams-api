class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :update, :destroy]
    
    # GET /employees
    def index
        employees = Employee.all
        render json: employees, status: :ok
    end

    # GET teams/:id/employees
    def index
        team_employees = Team.employee.all
        render json: team_employees, status: :ok
    end
    
    # GET /employees/:id
    def show
        render json: @current_employee, status: :ok
    end

    # POST /employees
    def create
      employee = Employee.new(employee_params)
  
      if employee.save
        render json: employee, status: :created
      else
        render json: employee.errors, status: :unprocessable_entity
      end
    end
    
    # PUT /employees/:id
    def update
      if @current_employee.update(employee_params)
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
  
    private

    def set_employee
        @current_employee = Employee.find(params[:id])
    end
  
    def employee_params
      params.permit(:first_name, :last_name, :job_title, :profile_image)
    end
end
