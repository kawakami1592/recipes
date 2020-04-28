class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @category_parent = Category.where("ancestry is null")
    @woman_easy = Recipe.joins(:user).where(difficulty_id: [1,2,3]).where("users.sex_id = 2").last(5)
    @woman_luxury = Recipe.joins(:user).where(difficulty_id: [4,5]).where("users.sex_id = 2").last(5)
    @man_easy = Recipe.joins(:user).where(difficulty_id: [1,2,3]).where("users.sex_id = 1").last(5)
    @man_luxury = Recipe.joins(:user).where(difficulty_id: [4,5]).where("users.sex_id = 1").last(5)

    # binding.pry
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

    if current_user.sex_id == 1
      @purpose = "作ってあげたい"
      @category_parent = Category.where("ancestry is null")
      @category_children = Category.find_by(id: 1).children
      @category_grandchildren = Category.find_by(id: 2).children
      #JSで３階層目を実装予定
      # @category_grandchildren = Category.find("#{params[:child_id]}").children
    elsif current_user.sex_id == 2
      @purpose = "作ってほしい"
      @category_parent = Category.where("ancestry is null")
      @category_children = Category.find_by(id: 1).children
      @category_grandchildren = Category.find_by(id: 2).children
    else
      redirect_to root_path, notice: "ログインしてください"
    end

  end

  def create
    @recipe = Recipe.new(recipe_params)
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
    params.require(:recipe).permit(:title, :category_id, :text, :image, :point, :difficulty_id, ingredients_attributes: [:ingredient, :quantity], makeds_attributes: [:text, :image]).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

end

