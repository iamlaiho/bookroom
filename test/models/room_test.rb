require 'test_helper'

class RoomTest < ActiveSupport::TestCase
	def setup
		@room = rooms(:validroom)
	end

   	test "valid room" do
    	assert @room.valid?
    end

    test "invalid room without number" do
    	@room.number = nil
    	refute @room.valid?
    	assert_not_nil @room.errors[:number]
    end
end