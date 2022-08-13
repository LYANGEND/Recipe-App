class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.all.where(user_id: current_user).order(created_at: :desc).with_attached_image
  end

  def show
    data = Recipe.where(id: params[:id]).with_attached_image
    @recipe = data[0]
    @recipe_foods = Food.all.joins('INNER JOIN recipe_foods ON foods.id = recipe_foods.food_id')
      .order(created_at: :desc).select('foods.*, recipe_foods.quantity, recipe_foods.id as recipe_foods_id')
      .where(recipe_foods: { recipe_id: params[:id] }).with_attached_image
    return unless current_user
  end

  def new
    @user = current_user
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
        flash[:success] = 'Recipe created successfully'
        redirect_to recipes_path
    else
        flash.now[:danger] = 'Recipe was not created because <ul class="error-list">'
        @recipe.errors.full_messages.each do |msg|
          flash.now[:danger] += "<li>#{msg}</li>"
        end
        flash.now[:danger] += '</ul>'
        render :new
    end
  end

  def update
    Recipe.find(params[:id]).update(public: params[:recipe][:public])
  end

  private

  def recipe_params
    params.permit(:name, :preparation_time, :cooking_time, :description, :image, :user_id)
  end
end
