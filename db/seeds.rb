# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Document.destroy_all
User.create!(first_name: "Ramprabhu",
             last_name: "Narayanasamy",
             email: 'nramprabu@gmail.com',
             password: '123456',
             password_confirmation: '123456',
             is_admin: true,
             dob: '1989-01-14',
             gender: 'male',
             mobileno: '9600804251',
             address: 'Chennai',
             status: 'single')
