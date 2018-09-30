require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
	test "should redirect to booking index" do
		get bookings_path
		assert_response :success
		post bookings_path, params: { :booking => {:user_id => '444182034', :room_id => '628435421', :start_date => '2018-10-01 09:00:00 UTC', :end_date => '2018-10-01 10:00:00 UTC'} }
		assert_equal 'You have successfully booked a room!', flash[:success]
	end

	test "should show error message" do
		get bookings_path
		assert_response :success
		post bookings_path, params: { :booking => {:user_id => '1', :room_id => '101', :start_date => '2018-10-01 10:00:00', :end_date => '2018-10-01 11:00:00'} }
		assert_equal 'Something went wrong. Please try again.', flash[:error]
	end
end
