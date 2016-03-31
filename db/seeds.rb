# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    admin false
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :poem do
    title { "#{Faker::Hacker.adjective.capitalize} #{Faker::Hacker.noun.capitalize}" }
    content { "#{Faker::Hacker.adjective.capitalize} #{Faker::Hacker.noun}" }
    user_id { User.order("RANDOM()").first.id }
  end
end


# 20.times do
#   FactoryGirl.create(:user)
# end

25.times do
  FactoryGirl.create(:poem)
end