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

  factory :movie do
    title { Faker::Book.title }
    director { Faker::Book.author }
    runtime_in_minutes { Faker::Number.between(90, 180) }
    description { Faker::Book.genre }
    release_date { Faker::Date.backward(36520) }
    image { Faker::Placeholdit.image("200x400", 'jpg') }
  end
end


# 100.times do
#   FactoryGirl.create(:user)
# end

25.times do
  FactoryGirl.create(:movie)
end