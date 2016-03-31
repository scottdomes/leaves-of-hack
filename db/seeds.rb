# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def poem_generator
  poem = ""
  rand(3..12).times do
    poem += poem_line + "\n"
  end
  poem
end

def poem_line
  number = rand(0..4)
  case number
  when 0
    Faker::Hacker.noun
  when 1
    "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}"
  when 2
    "#{Faker::Hacker.adjective} #{Faker::Hacker.abbreviation} #{Faker::Hacker.verb} #{Faker::Hacker.noun}"
  when 3
    Faker::Hacker.say_something_smart
  when 4
    Faker::Hipster.word
  end  
end

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
    content { poem_generator }
    user_id { User.order("RANDOM()").first.id }
  end
end


20.times do
  FactoryGirl.create(:user)
end

25.times do
  FactoryGirl.create(:poem)
end

User.create(
  firstname: "Scott",
  lastname: "Domes",
  email: "s@s.com",
  password: "123123",
  admin: true
  )