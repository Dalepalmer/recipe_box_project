require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  @ingredients = Ingredient.all()
  @categories = Category.all()
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

post('/category') do
  @categories = Category.all()
  name = params.fetch("category_name")
  Category.create({:name => name})
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

post('/categories_recipes_add') do
  category_id = params.fetch("category_id")
  @categories = Category.find(category_id)
  recipe_id = params.fetch("recipe_id")
  @recipe = Recipe.find(recipe_id)
  @recipe.categories().<<(Category.find(category_id))
  redirect '/'
end

post("/recipes") do
  name = params.fetch("name")
  @recipe = Recipe.new({:name => name})
  @recipe.save()
  if @recipe.save()
    redirect '/'
  else
    erb(:errors)
  end
end

get('/recipes/:id') do
  recipe_id = params.fetch("id").to_i
  @recipe = Recipe.find(recipe_id)
  @ingredients = @recipe.ingredients()
  @categories = @recipe.categories()
  erb(:recipe)
end

get('/ingredients/:id') do
  ingredient_id = params.fetch("id").to_i
  @ingredient = Ingredient.find(ingredient_id)
  erb(:ingredient)
end
