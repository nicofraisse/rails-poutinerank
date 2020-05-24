# DATA
puts 'destroying users...'
User.destroy_all

puts 'destroying restaurants...'
Restaurant.destroy_all

puts 'destroying restaurant categories...'
RestaurantCategory.destroy_all

restaurant_categories = [
  { name: 'Diner' },
  { name: 'Pub' },
  { name: 'Fast Food' },
  { name: 'Fancy' }
]

puts 'creating god...'
god = User.create!(
  email: 'god@gmail.com',
  password: '123123',
  first_name: 'God'
)

restaurant_categories.each do |r_c|
  RestaurantCategory.create(r_c)
  puts 'created ' + r_c[:name] + ' restaurant category'
end


restaurants = [
  {
    name: 'Poutineville',
    address: '3930 rue des pommiers, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample,
    user: god
  },
  {
    name: 'Poutine Pro',
    address: '6767 rue Hutchisson, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample,
    user: god
  },
  {
    name: 'Poutine Laurier',
    address: '5350 avenue Decelles, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample,
    user: god
  },
  {
    name: 'La banquise',
    address: '750 avenue Laval, Montreal, QC',
    price_index: rand(1..3),
    restaurant_category: RestaurantCategory.all.sample,
    user: god
  },
]


restaurants.each do |restaurant|
  Restaurant.create(restaurant)
  puts 'created ' + restaurant[:name] + ' restaurant'
end
