class BookingsController < ApplicationController
	
	def index
		@user = User.find(params[:id])
		@booked_slots = Booking.where(user_id: params[:id])
	end

	def new
		@search = BookingSearch.new(params[:start_date])
		@bookings = @search.scope
		get_available_slots
		@selected_date = params[:start_date]
	end

	def create
		@booking = Booking.new(booking_params)
		if @booking.save
			logger.debug "created"
			redirect_to bookings_path(id: session[:user_id])
		else 
			logger.debug "#{@booking.errors.messages}"
		end
	end

	private
		def booking_params
			params.require(:booking).permit(:room_id, :start_date, :end_date, :user_id)
		end

		def get_available_slots
			start_time_date = params[:start_date].to_time.next_day.utc.beginning_of_day
			end_time_date = params[:start_date].to_time.next_day.utc.end_of_day

			create_all_slots(start_time_date)

			remove_booked_slots(start_time_date, end_time_date)
		end

		def create_all_slots(start_time_date)
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

		def remove_booked_slots(start_time_date, end_time_date)
			#bookings = get_booked_slots(start_time_date, end_time_date)

			@bookings.each do |booking|
				@available_slots.delete_if{|available_slot| available_slot.start_date == booking.start_date && available_slot.room.id == booking.room.id}
			end
		end

		def get_booked_slots(start_time_date, end_time_date)
			Booking.where('start_date BETWEEN ? AND ?', start_time_date, end_time_date)
		end
end
