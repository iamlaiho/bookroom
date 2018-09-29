require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = users(:validuser)
	end

   	test "valid user" do
    	assert @user.valid?
    end

    test "invalid without name" do
    	@user.name = nil
    	refute @user.valid?, 'save user without a name'
    	assert_not_nil @user.errors[:name],  'validation error for name present'
   	end

    test "invalid with name less than five characters" do
    	@user.name = "John"
    	refute @user.valid?, 'user with less than five characters'
    	assert_not_nil @user.errors[:name],  'validation error for name present'
   	end
end
