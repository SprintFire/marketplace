# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'admin@sprintfire.com', password: 'Spr!ntFire2016', password_confirmation: 'Spr!ntFire2016')

Category.create!(title: 'Uncategorized', description: 'This is the default category.')
