class User < ApplicationRecord
	has_many :bookings
	has_many :rooms, through: :bookings

	validates :name, length: { minimum: 5 , message: 'Please enter an username with a minimum of 5 characters.'}
end
