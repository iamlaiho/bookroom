class UsersController < ApplicationController
	
	def index
		@user = User.new
		session.delete(:user_id)
		session.delete(:user_name)
	end

	def create
 		@user = User.find_or_create_by(user_params)
 		if @user.errors.any?
 			render 'index'
 		else
 			session[:user_id] = @user.id
 			session[:user_name] = @user.name
 			redirect_to bookings_path
 		end
    end

    private
    	def user_params
    		params.require(:user).permit(:name)
    	end
end
