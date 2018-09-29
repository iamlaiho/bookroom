class BookingsController < ApplicationController
	
	def index
		@booked_slots = Booking.where(user_id: session[:user_id])
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
		else
			flash[:success] = "You have successfully booked a room!"
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
			start_time_date = params[:start_date].to_date
			start_hour = 8
			if start_time_date.today?
				hour_diff = ((DateTime.now - DateTime.now.beginning_of_day) * 24).round
				if hour_diff > 8
					start_hour = hour_diff
				end
			end

			@available_slots = []
			rooms = Room.all
			rooms.each do |room|
				for hour in start_hour...18 do
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
