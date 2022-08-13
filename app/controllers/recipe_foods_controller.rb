class RecipeFoodsController < ApplicationController
  def index; end

  def new
    @recipe_food = RecipeFood.new
    @recipe_food_ids = RecipeFood.all.where(recipe_id: params[:recipe_id]).pluck(:food_id)
    @foods = Food.all.where(user_id: current_user.id).where.not(id: @recipe_food_ids).order(name: :asc)
    @recipe = Recipe.where(recipe_id: params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new
    @recipe_food_ids = RecipeFood.all.where(recipe_id: params[:recipe_id]).pluck(:food_id)
    @foods = Food.all.where(user_id: current_user.id).where.not(id: @recipe_food_ids).order(name: :asc)
    @recipe = Recipe.find(params[:recipe_id])
    recipe_food = RecipeFood.new(recipe_food_params)
    recipe_food.recipe_id = params[:recipe_id]
    if recipe_food.save
      flash[:success] = 'Food was successfully added to recipe.'
    else
      flash[:danger] = 'Food was not added to recipe because <ul class="error-list">'
      recipe_food.errors.full_messages.each do |msg|
        flash[:danger] += "<li>#{msg}</li>"
      end
      flash[:danger] += '</ul>'
    end
    redirect_to new_recipe_recipe_food_path(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
