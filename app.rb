require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  @ingredients = Ingredient.all()
  erb(:index)
end

post('/recipes') do
  @recipes = Recipe.all()
  name = params.fetch("name")
  Recipe.create({:name => name})
  redirect '/'
end

post('/ingredients') do
  @ingredients = Ingredient.all()
  name = params.fetch("ingredient_name")
  Ingredient.create({:ingredient_name => name})
  redirect '/'
end

post('/ingredients_recipes_add') do
  recipe_id = params.fetch("recipe_id")
  @recipe = Recipe.find(recipe_id)
  ingredient_ids_array = params.fetch("ingredient_ids_array")
  ingredient_ids_array.each() do |ingredient_id|
    @recipe.ingredients().<<(Ingredient.find(ingredient_id))
  end
  redirect '/'
end

get('/recipes/:id') do
  recipe_id = params.fetch("id").to_i
  @recipe = Recipe.find(recipe_id)
  @ingredients = @recipe.ingredients()
  erb(:recipe)
end
