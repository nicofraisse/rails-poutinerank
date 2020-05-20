# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RestaurantCategory.destroy_all
Restaurant.destroy_all

RestaurantCategory.create(name: 'diner')
RestaurantCategory.create(name: 'pub')
RestaurantCategory.create(name: 'fast food')

Restaurant.new(name: 'Poutineville', category: 'NA', address: '4 rue des fromafes', 'price_index': 4)
