def create_and_activate_user(_name)
  user = User.create!(name: 'user', email: 'test@gmail.com', password: 'password')
  user.save!
  user
end

def create_recipes_for_user(_user, count: 1)
  recipes = []
  count.times do |i|
    recipes << Recipe.create!(
      user: 'user',
      name: "Recipe #{i}",
      cooking_time: 1,
      preparation_time: 1,
      description: "This is body of recipe #{i}",
      public: false
    )
  end
  recipes
end

def create_foods_for_user(_user, count: 1)
  foods = []
  count.times do |i|
    foods << Food.create!(
      user: 'user',
      name: "Food #{i}",
      measurement_unit: 'kg',
      price: 5
    )
  end
  foods
end
