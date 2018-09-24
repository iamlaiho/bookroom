class BookingSearch
	include ActiveModel::Model
	attr_accessor :start_time_date

	validates :start_time_date, format: { with: /\A\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])\z/, message: 'Please enter a valid date (YYYY-MM-DD).' }

	def initialize(params)
		@start_time_date = params
	end

	def scope
		puts "start: #{@start_time_date}"
		Booking.where('start_date BETWEEN ? AND ?', @start_time_date.to_time.utc.beginning_of_day, @start_time_date.to_time.utc.end_of_day)
	end
end
