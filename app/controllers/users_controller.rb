class UsersController < ApplicationController
    before_action :authenticate_request, only: [:show, :update, :destroy]

    # POST /signup (Sign Up view)
    def create
      user = User.new(user_params)
  
      if user.save
        token = jwt_encode(user_id: user.id)
        render json: { token: token }, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  
    # GET /users/:id
    def show
      render json: @current_user, status: :ok
    end
  
    # PUT /users/:id
    def update
      if @current_user.update(user_params)
        render json: @current_user, status: :ok
      else
        render json: @current_user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /users/:id
    def destroy
      if @current_user.destroy
        render json: nil, status: :ok
      else
        render json: @current_user.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  
    def jwt_encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secret_key_base)
    end
end
