#encoding: utf-8
class RecipesController < ApplicationController
  def show
    getFood
    getRecipe
    @recipes = @food.recipes
  end

  def getFood
    if(params[:food_id].nil?)
      redirect_to foods_path, alert: "Najskôr si vyber jedlo."
    end
    @food = Food.find(params[:food_id])
  end

  def getRecipe
    @recipe = Recipe.find(params[:id])
  end

  def myRecipes

  end

  def index
    getFood
    @recipes = @food.recipes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  def new
    getFood
    @recipe = Recipe.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  def edit
     getRecipe
    getFood
  end

  def update
    getRecipe
    getFood
    if @recipe.update_attributes(params[:recipe])
      flash[:success] = 'Detaily receptu boli úspešne zmenené.'
      redirect_to food_recipe_path(@food,@recipe)
    else
      flash[:error] = "Nové detaily sa nepodarilo uložiť"
      redirect_to edit_food_recipe_path(@recipe,@food)
    end
  end

  def create
    getFood
    @recipe = Recipe.new(params[:recipe])
    @recipe.food = @food
    UsersRecipe.create(user:current_user,recipe:@recipe);
    if @recipe.save
      flash[:success] = 'Recept bol úspešne vytvorený.'
      render 'index'
    else
      render 'new'
    end
  end

  def destroy
    getRecipe
    getFood
    if (@recipe.users.first == current_user || current_user == User.find_by_username('admin'))
      @recipe.destroy
      flash[:success] = "Recept bol úspešne odstránený."
      redirect_to myRecipes_path
    else
      flash[:error] = "Nemôžeš vymazať recept iného používateľa."
      render 'show'
    end
  end
end
