# require 'faker'
require 'factory_girl_rails'

occupiables = FactoryGirl.create_list(:occupiable, 3)

bookings = occupiables.map do |occupiable|
    FactoryGirl.create_list(:booking, 3, occupiable: occupiable)
end
