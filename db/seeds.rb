# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 0..25
  User.create(
    name: "test name",
    email: "email#{i}#{DateTime.now}", # email should be unique
    phone_number: "9999999999",
    address: "test address",
    hobbies: "Playing volleyball"
  )
end
