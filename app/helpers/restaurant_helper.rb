module RestaurantHelper
  def ratingsData
    Restaurant.all.map do |restaurant|
      avg_global_rating = avg_of_children(restaurant, Review, 'global_rating')
      avg_service_rating = avg_of_children(restaurant, Review, 'service_rating')
      avg_fries_rating = avg_of_children(restaurant, Review, 'fries_rating')
      avg_sauce_rating = avg_of_children(restaurant, Review, 'sauce_rating')
      avg_cheese_rating =  avg_of_children(restaurant, Review, 'cheese_rating')
      [
        restaurant.name,
        {
          avg_global_rating: avg_global_rating,
          avg_service_rating: avg_service_rating,
          avg_fries_rating: avg_fries_rating,
          avg_sauce_rating: avg_sauce_rating,
          avg_cheese_rating: avg_cheese_rating,
          PS_rating: compute_PS_rating(avg_global_rating,
                                        avg_service_rating,
                                        avg_fries_rating,
                                        avg_sauce_rating,
                                        avg_cheese_rating,
                                        restaurant.poutine_price)
        }
      ]
    end.to_h
  end
  # private

  def avg_of_children(parent_instance, child_class, child_class_property)
    all_children_of_parent = ActiveRecord::Base.connection.execute("
      SELECT *
      FROM #{child_class.name.downcase.pluralize}
      JOIN #{parent_instance.class.name.downcase.pluralize}
      ON reviews.restaurant_id = restaurants.id
      WHERE #{parent_instance.class.name.downcase.pluralize}.name = '#{parent_instance.name.gsub("'", "\'\'")}'
      ").to_a
    unless all_children_of_parent.empty?
      all_children_of_parent.map{ |child| child[child_class_property]}.sum.to_f / all_children_of_parent.count
    end
    # else returns nil by default, which is what we want
  end

  def compute_PS_rating(global, service, fries, sauce, cheese, price)
    unless [global, service, fries, sauce, cheese, price].include?(nil)
      (global + service + fries + sauce + cheese - price) / 10
    end
  end
end
