class UsersController < ApplicationController
	
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
	end

	def create
 		@user = User.find_or_create_by(user_params)
 		redirect_to bookings_path(id: @user)
    end

    private
    	def user_params
    		params.require(:user).permit(:name)
    	end
end
