# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

puts 'destroy old data'

Listing.destroy_all

10.times do
  user = User.new(
    username: Faker::Name.unique.name,
    email: Faker::Internet.email,
    address:Faker::Address.full_address,
    password:Faker::Alphanumeric.alphanumeric(number: 8)
  )
   if user.valid?
    user.save!
  end

  (1..3).to_a.sample.times do
    listing = Listing.new(
      title: Faker::Food.vegetables,
      description: Faker::Food.description,
      category: Faker::Food.dish,
      quantity: (1..10).to_a.sample,
      unit_price:(1..10).to_a.sample,
      expiry_date: Date.new(),
      user: User.all.sample
  )
    if listing.valid?
    file = URI.open('https://source.unsplash.com/1600x900/?vegetables')
    listing.photo.attach(io: file, filename: 'images.png', content_type: 'image/png')
    listing.save!
  end
 end
end
