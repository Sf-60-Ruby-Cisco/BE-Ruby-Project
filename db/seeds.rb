# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed the db and use credentials from .env to log in as an admin or create another admin in console.
user = User.create(
  username: ENV['SIDEKIQ_USER'],
  email: ENV['SIDEKIQ_EMAIL'], 
  password: ENV['SIDEKIQ_PASSWORD'],
  password_confirmation: ENV['SIDEKIQ_PASSWORD'],
  admin: true
)
user.skip_confirmation!
user.save!