class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end
    
      private
    
      def user_params
        params.permit(:first_name,:last_name,:email,:username, :password, :password_confirmation)
      end
end
