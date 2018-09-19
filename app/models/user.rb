class User < ApplicationRecord
	has_many :bookings
	has_many :rooms, through: :bookings

	validates :name, presence: true, length: {minimum: 5}
end
