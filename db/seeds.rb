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


# #creating users for testing
10.times do
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username(specifier: 5..10), 
    password: '123456',
    password_confirmation: '123456',
    confirmed_at: Time.now       
  ) 
end

# # If you will use it to seed DB in development with pictures have to turn off active_job.queue_adapter = sidekiq in 
# config/application.rb because it's trying to connect and returning errors!

User.all.each do |i|
  if !i.content.present?
      i.content.attach(io: URI.open(Faker::LoremFlickr.image(search_terms: ['face'])),
                        filename: "avatar.jpg")
  end
end
