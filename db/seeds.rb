# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

smoking = Activity.create(name: 'Smoking')
1.upto(7) { |num| smoking.resets.create({ datetime: num.days.ago }) }

num_3 = Activity.create(name: "#3")
1.upto(14) { |num| num_3.resets.create({ datetime: num.days.ago }) }
