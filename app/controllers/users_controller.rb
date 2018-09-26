class UsersController < ApplicationController
	
	def index
		@user = User.new
		session.delete(:user_id)
	end

	def create
 		@user = User.find_or_create_by(user_params)
 		if @user.errors.any?
 			render 'index'
 		else
 			session[:user_id] = @user.id
 			redirect_to bookings_path(id: @user)
 		end
    end

    private
    	def user_params
    		params.require(:user).permit(:name)
    	end
end
