# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"
require 'pry-byebug'

puts 'destroy old data'

User.destroy_all

3.times do
  user = User.new(
    username: Faker::Name.unique.name,
    email: Faker::Internet.email,
    address:Faker::Address.full_address,
    password:Faker::Alphanumeric.alphanumeric(number: 8)
    )
  user.save!
end

User.all.each do |user|
  3.times do
    listing = Listing.new(
      title: Faker::Food.vegetables,
      description: Faker::Food.description,
      category: Faker::Food.dish,
      quantity: (1..10).to_a.sample,
      unit_price:(1..10).to_a.sample,
      expiry_date: Date.new(),
      user: User.first
    )
    file = URI.open("https://source.unsplash.com/400x300/?#{listing.title}")
    listing.photo.attach(io: file, filename: "#{listing.title}.png", content_type: 'image/png')
    listing.save!
  end
end
