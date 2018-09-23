class BookingsController < ApplicationController
	
	def index
		@user = User.find(params[:id])
		@booked_slots = Booking.where(user_id: params[:id])
	end

	def new
		@search = BookingSearch.new(params[:start_date])
		if @search.valid?
			@bookings = @search.scope
			get_available_slots
			@selected_date = params[:start_date]
		else
			@search.errors.each do |field, msg|
				flash[:error] = msg
			end
			redirect_to bookings_path(id: session[:user_id])
		end 
	end

	def create
		@booking = Booking.new(booking_params)
		if !@booking.save
			flash[:error] = "Something went wrong. Please try again."
		end
		redirect_to bookings_path(id: session[:user_id])
	end

	private
		def booking_params
			params.require(:booking).permit(:room_id, :start_date, :end_date, :user_id)
		end

		def get_available_slots
			create_all_slots
			remove_booked_slots
		end

		def create_all_slots
			start_time_date = params[:start_date].to_time.next_day.utc.beginning_of_day
			@available_slots = []
			rooms = Room.all
			rooms.each do |room|
				for hour in 8...18 do
					@available_slots << Booking.new(
									:room_id => room.id, 
									:start_date => start_time_date + hour.hours, 
									:end_date => start_time_date + (hour + 1).hours)
					end
			end
		end

		def remove_booked_slots
			@bookings.each do |booking|
				@available_slots.delete_if{|available_slot| available_slot.start_date == booking.start_date && available_slot.room.id == booking.room.id}
			end
		end
end
