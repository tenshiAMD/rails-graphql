# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  require 'faker'
  require 'ffaker'

  user = Lia::User.new
  user.username = 'test'
  user.email = 'test@gmail.com'
  user.profile_attributes = { first_name: 'test', middle_name: 'test', last_name: 'test' }
  user.save
  user.add_role :system_administrator

  (1..10).each do |n|
    Lia::Section.create(name: "#{Faker::App.name}#{n}", position: n)
    Lia::Subject.create(name: "#{Faker::App.name}#{n}", position: n)
  end

  (1..10).each do |n|
    Lia::Section.create(name: "#{Faker::App.name}#{n}", parent_id: Faker::Number.between(1, 10), position: n)
    Lia::Subject.create(name: "#{Faker::App.name}#{n}", parent_id: Faker::Number.between(1, 10), position: n)
  end

  (4..8).each do |n|
    Lia::CourtDivision.create(name: "#{n}th division", short_name: "#{n}th division")
  end

  20.times do
    document = Lia::Document.new
    document.issuance_no = Faker::Lorem.sentence
    document.title = Faker::Lorem.sentence
    document.signatory = Faker::Name.name
    document.committee = Faker::Name.name
    document.councilor = Faker::Name.name
    document.content = Faker::Lorem.paragraphs(20)
    document.doc_date = Faker::Date.between(30.years.ago, Time.zone.today)
    document.doc_year = document.doc_date.year
    document.publish = Faker::Boolean.boolean
    document.section_ids = Faker::Number.between(1, 20)
    document.subject_ids = Faker::Number.between(1, 20)
    document.division_id = Faker::Number.between(1, 5)
    document.save
  end
end
