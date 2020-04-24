class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @category_parent = Category.where("ancestry is null")
    @recipe = Recipe.includes(:user).last(3)
  end

  def show
    if @recipe.blank?
      redirect_to root_path, notice: "このレシピは削除されています"
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.new
    @recipe.makeds.new
    @category_parent = Category.where("ancestry is null")
  end

  def create
    @recipe = Recipe.new(recipe_params)
    binding.pry
    if @recipe.save
      redirect_to root_path, notice: "投稿できました"
    else
      render :new, notice: "投稿できませんでした"
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if recipe.present?
      if recipe.destroy
        redirect_to root_path, notice: "削除しました"
      else
        redirect_to root_path, notice: "削除に失敗しました"
      end
    else
      redirect_to root_path, notice: "レシピが見つかりません"
    end
  end


  private

  def recipe_params
    # params.require(:recipe).permit(:title, :category_id, :text, :image, :point).merge(user_id: current_user.id)
    params.require(:recipe).permit(:title, :category_id, :text, :image, :point, ingredients_attributes: [:ingredient, :quantity], makeds_attributes: [:text, :image]).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

end
