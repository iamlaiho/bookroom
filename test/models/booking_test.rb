require 'test_helper'

class BookingTest < ActiveSupport::TestCase
	def setup
		@user = users(:validuser)
		@room = rooms(:validroom)
		@booking = Booking.new(user_id: @user.id, room_id: @room.id)
	end

	test "should be valid" do
		assert @booking.valid?
	end

	test "invalid without user id" do
		@booking.user_id = nil
		@booking.valid?
		assert @booking.errors.key?(:user)
	end

	test "invalid without room id" do
		@booking.room_id = nil
		@booking.valid?
		assert @booking.errors.key?(:room)
	end
end