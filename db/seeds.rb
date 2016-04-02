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
    poem += prefixer + poem_line + "\n"
  end
  poem
end

def poem_line
  number = rand(0..8)
  case number
  when 0
    Faker::Hacker.noun
  when 1
    "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}"
  when 2
    "#{Faker::Hacker.adjective} #{Faker::Hacker.abbreviation} #{Faker::Hacker.verb} #{Faker::Hacker.noun}"
  when 3
    "#{Faker::Company.buzzword} #{Faker::Company.buzzword}"
  when 4
    Faker::Hipster.word
  when 5
    "#{Faker::Hacker.adjective} #{Faker::Team.creature}"
  when 6
    "#{Faker::Hacker.abbreviation}... #{Faker::Hacker.noun}"
  when 7
    "#{Faker::Hacker.noun} is... "
  when 8
    "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun} is #{Faker::Hacker.adjective}"
  end
end

def prefixer
  number = rand(0..15)
  case number
  when 5
    "Perhaps "
  when 6
    "Maybe "
  when 7
    "Sometimes "
  when 8
    "I feel "
  when 9
    "I am "
  when 10
    "See "
  when 11
    "As "
  when 12
    "He says "
  when 13
    "She said "
  when 14
    "Obviously "
  when 15
    "Always "
  else
    ""
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
    title { poem_line }
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