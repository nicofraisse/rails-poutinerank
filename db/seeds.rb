
RestaurantCategory.create(name: 'Casse-croûte')

# # DATA
# puts 'destroying users...'
# User.destroy_all

# puts 'destroying restaurants...'
# Restaurant.destroy_all

# puts 'destroying restaurant categories...'
# RestaurantCategory.destroy_all

# puts 'creating god...'
# god = User.create!(
#   email: 'god@gmail.com',
#   password: '123123',
#   first_name: 'God'
# )

# restaurant_categories = [
#   { name: 'Normal' },
#   { name: 'Fast Food' },
#   { name: 'Food Truck' }
# ]

# poutine_categories = [
#   { name: 'Classique' },
#   { name: 'Spéciale' },
#   { name: 'Végan' }
# ]

# restaurant_categories.each do |r_c|
#   RestaurantCategory.create(r_c)
#   puts 'created ' + r_c[:name] + ' restaurant category'
# end

# poutine_categories.each do |p_c|
#   PoutineCategory.create(p_c)
#   puts 'created ' + p_c[:name] + ' poutine category'
# end


# restaurants = [
#   {
#     name: 'Poutineville',
#     address: '3930 rue des pommiers, Montreal, QC',
#     poutine_price: 7.95,
#     restaurant_category: RestaurantCategory.all.sample,
#     user: god
#   },
# ]

# restaurants.each do |restaurant|
#   Restaurant.create(restaurant)
#   puts 'created ' + restaurant[:name] + ' restaurant'
# end
