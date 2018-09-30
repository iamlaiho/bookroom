require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "should get index" do
		get users_url
		assert_response :success
	end
end

require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
	test "should get index" do
		puts "booking"
		assert_redirected_to bookings_url
	end
end
