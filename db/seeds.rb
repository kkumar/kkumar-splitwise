# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating 1 user and their 3 friends/connections
# Create 3 users
3.times do |i|
  User.create!(
    email: "user#{i+1}@example.com",
    name: "User #{i+1}",
    password: 'test321@@',
    password_confirmation: 'test321@@'
    # Add any other required fields according to your User model validations
  )
end

# Assuming the first user should be connected with all other users
first_user = User.first

# Start from the second user since the first user is the one to whom others will be connected
User.where.not(id: first_user.id).each do |user|
  UserConnection.create!(
    user: first_user,
    connection: user,
    status: 'accepted' # or :pending if you want the connections to be initially unconfirmed
  )
end

puts 'Seed data created successfully!'
