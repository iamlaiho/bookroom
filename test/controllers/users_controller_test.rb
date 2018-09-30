require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "should get index" do
		get users_path
		assert_response :success
	end

	test "should redirect to booking index" do
		get users_path
		assert_response :success
		post users_path, params: { :user => { :name => 'Michael'} }
		assert_redirected_to bookings_path
	end
end