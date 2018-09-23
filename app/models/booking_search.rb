class BookingSearch

	def initialize(params)
		@start_time_date = params.to_time.next_day.utc.beginning_of_day
		@end_time_date = params.to_time.next_day.utc.end_of_day
	end

	def scope
		Booking.where('start_date BETWEEN ? AND ?', @start_time_date, @end_time_date)
	end
end
