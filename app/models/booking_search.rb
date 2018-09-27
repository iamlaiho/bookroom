class BookingSearch
	include ActiveModel::Model
	attr_accessor :start_time_date

	validates :start_time_date, format: { with: /\A\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])\z/, message: 'Please enter a valid date (YYYY-MM-DD).' }
	validate :search_date_cannot_be_in_the_past 

	def initialize(params)
		@start_time_date = params
	end

	def search_date_cannot_be_in_the_past
		if start_time_date.present? && start_time_date.to_date < Date.today.to_date
    		errors.add(:start_time_date, "You cannot book a room in the past!")
 		end
    end 

	def scope
		Booking.where(start_date: @start_time_date.to_date.midnight..@start_time_date.to_date.end_of_day)
	end
end
