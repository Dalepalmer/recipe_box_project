class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:ingredients)
  has_and_belongs_to_many(:categories)
  has_one(:instruction)

  validates(:name, :presence => true)

  # define_singleton_method("search") do |ingredient_id|
  #   @recipe = Recipe.all()
  #   @ingredient = Ingredient.find(ingredient_id)
  #

end
