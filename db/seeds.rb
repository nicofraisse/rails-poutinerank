# DATA


'destroying restaurants...'
Restaurant.destroy_all

'destroying restaurant categories...'
RestaurantCategory.destroy_all

restaurant_categories = [
  { name: 'Diner' },
  { name: 'Pub' },
  { name: 'Fast Food' },
  { name: 'Fancy' }
]


restaurant_categories.each do |r_c|
  RestaurantCategory.create(r_c)
  puts 'created ' + r_c[:name] + ' restaurant category'
end


restaurants = [
  {
    name: 'Poutineville',
    address: '3930 rue des pommiers, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample
  },
  {
    name: 'Poutine Pro',
    address: '6767 rue Hutchisson, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample
  },
  {
    name: 'Poutine Laurier',
    address: '5350 avenue Decelles, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample
  },
  {
    name: 'La banquise',
    address: '750 avenue Laval, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample
  },
]


restaurants.each do |restaurant|
  Restaurant.create(restaurant)
  puts 'created ' + restaurant[:name] + ' restaurant'
end
