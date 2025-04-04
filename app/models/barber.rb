class Barber < ApplicationRecord
    belongs_to :user
    has_many :working_hours
    has_many :appointments
    
end
