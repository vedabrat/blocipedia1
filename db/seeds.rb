# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include Faker


# Create an admin user
 admin = User.create!(
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )

 # Create a member
 member = User.create!(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )


 #Create Users

   5.times do
     user = User.create!(
     email:    Faker::Internet.email,
     password: Faker::Internet.password
     )
   end
   users = User.all

 # Create Wikis
   15.times do
     Wiki.create!(
       title: Faker::Lorem.sentence,
       body: Faker::Lorem.paragraph,
       private: false
     )
   end
   wikis = Wiki.all
   wiki = Wiki.all

   # Create an admin member
   admin = User.create!(
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
   )

   #Create a standard member
   member = User.create!(
   email:    'member@example.com',
   password: 'helloworld'
   )

   #Create a premium member
   premium = User.create!(
     email:    'premium@example.com',
     password: 'helloworld',
     role:     'premium'
   )

 puts "Seed finished"
 puts "#{User.count} users created."
 puts "#{Wiki.count} wikis created."
