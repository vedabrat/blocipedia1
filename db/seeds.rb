# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include Faker


# Create an admin user
User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a member
User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)

# Create a premium member
User.create!(
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)

# Create Users
5.times do |i|
  User.create!(
    email:    "email#{i}@test.com",
    password: "password#{i}"
  )
end

# Create Wikis
15.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: false,
    user: User.all.sample
  )
end

5.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: true,
    user: User.where(role: 'premium').all.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
