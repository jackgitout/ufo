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

User.destroy_all

6.times do
  user = User.new(
    username: Faker::Name.unique.name,
    email: Faker::Internet.email,
    address:Faker::Address.full_address,
    password:Faker::Alphanumeric.alphanumeric(number: 8)
    )
  puts "creating user: #{user.username}"
  fileav = URI.open(Faker::Avatar.image)
  user.avatar.attach(io: fileav, filename: "#{user.username}.png", content_type: 'image/png')
  user.save!
end

User.all.each do |user|
  2.times do
    listing = Listing.new(
      title: ["Spinach", "Carrots", "Broccoli", "Brussels Sprouts", "Green Peas", "Ginger", "Asparagus", "Cabbage", "Potatoes", "Turnip", "Capsicum", "Eggplant", "Bok Choy", "Radish", "Onion", "Celery", "Lettuce", "Artichoke", "Cauliflower","Avocado", "Cucumber"].sample,
      description: ["This leafy tops the chart as one of the healthiest vegetables, thanks to its impressive nutrient profile.", "Veggie packed with vitamin A","Belongs to the cruciferous family of vegetables, Eating this veggie may help prevent other types of chronic disease, too.", "A long history of use as a medicinal plant,with roots tracing all the way back to ancient China and Egypt.", "Like other leafy greens, this veggie is well-known for its health-promoting qualities, including its nutrient density and antioxidant content.", "They are considered a starchy vegetable. This means they have a higher amount of carbs and calories than non-starchy vegetables and may impact blood sugar levels when eaten in large amounts.", "This spring vegetable is rich in several vitamins and minerals, making it an excellent addition to any diet.", "This vegetable belongs to the cruciferous family of vegetables and, much like its relatives, is brimming with antioxidants and health-promoting properties.", "This veggie stands out for their vibrant color, sweet taste and impressive health benefits."].sample,
      category: ["Fresh Vegetables", "Frozen Vegetables", "Ready To Eat Salads", "Grow Your Own Microgreens", "Other Vegetables"].sample,
      quantity: (1..10).to_a.sample,
      unit_price:(1..10).to_a.sample,
      expiry_date: Date.today + 7,
      user: user
    )
    puts "creating listing: #{listing.title}"
    file = URI.open("https://source.unsplash.com/400x300/?#{listing.title}")
    listing.photo.attach(io: file, filename: "#{listing.title}.png", content_type: 'image/png')
    listing.save!
  end
end
