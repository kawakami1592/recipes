class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show, :list_by_category]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_category_parent, only: [:index, :list_by_category, :new, :edit]

  def index
    @woman_easy = Recipe.joins(:user).where(difficulty_id: [1,2,3]).where("users.sex_id = 2").last(5)
    @woman_luxury = Recipe.joins(:user).where(difficulty_id: [4,5]).where("users.sex_id = 2").last(5)
    @man_easy = Recipe.joins(:user).where(difficulty_id: [1,2,3]).where("users.sex_id = 1").last(5)
    @man_luxury = Recipe.joins(:user).where(difficulty_id: [4,5]).where("users.sex_id = 1").last(5)
    # binding.pry
  end

  def list_by_category
    @category = Category.find_by(id: params[:id])
    @recipes = Recipe.joins(:user).where(category_id: @category.indirect_ids)
  end

  def show
    if @recipe.present?
      @recipe.user.sex_id == 1 ? @purpose = "作ってあげたい" : @purpose = "作ってほしい"
      @man_like_count = Like.joins(:user).where(recipe_id: @recipe.id).where("users.sex_id = 1").count
      @woman_like_count = Like.joins(:user).where(recipe_id: @recipe.id).where("users.sex_id = 2").count
     
    else
      redirect_to root_path, notice: "このレシピは削除されています"
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.new
    @recipe.makeds.new
    current_user.sex_id == 1 ? @purpose = "作ってあげたい" : @purpose = "作ってほしい"
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
    if @recipe.present? && @recipe.user_id == current_user.id
      @recipe.user.sex_id == 1 ? @purpose = "作ってあげたい" : @purpose = "作ってほしい"
      
      # ⬇︎単体のカテゴリ⬇︎
      @category_grandchild = Category.find(@recipe.category_id)
      @category_child = @category_grandchild.parent.id
      @category_parent = @category_grandchild.parent.parent.id
      # ⬇︎カテゴリ配列⬇︎
      @category_children = @category_grandchild.parent.siblings
      @category_grandchildren= Category.find(@recipe.category_id).siblings
      # ⬇︎メイン画像⬇︎
      @image = @recipe.image
      gon.image = @recipe.image
      # ⬇︎ingredients配列⬇︎
      gon.ingredients = Ingredient.where(recipe_id: @recipe.id)
      # ⬇︎maked画像⬇︎
      @makeds = Maked.where(recipe_id: @recipe.id)
      @makeds_length = Maked.where(recipe_id: @recipe.id).length
      gon.makeds = Maked.where(recipe_id: @recipe.id)
      # binding.pry

    elsif @recipe.present? && @recipe.user_id != current_user.id
      redirect_to root_path,notice: "投稿者ではありません"
    else
      redirect_to root_path,notice: "レシピが見つかりません"
    end
  end

  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
    #親カテゴリーに紐付く子カテゴリーを取得
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
    #子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  def update
    if @recipe.present?
      if @recipe.update(update_recipe_params)
        redirect_to recipe_path(@recipe), notice: "編集できました"
      else
        render :edit, notice: "編集できませんでした"
      end
    else
      redirect_to root_path, notice: "レシピが見つかりません"
    end
  end

  def destroy

    unless @recipe.destroy
      redirect_to recipe_path(@recipe)
    end


  #   if recipe.present?
  #     if recipe.destroy
  #       redirect_to root_path, notice: "削除しました"
  #     else
  #       redirect_to root_path, notice: "削除に失敗しました"
  #     end
  #   else
  #     redirect_to root_path, notice: "レシピが見つかりません"
  #   end
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :category_id, :text, :image, :point, :difficulty_id, ingredients_attributes: [:ingredient, :quantity], makeds_attributes: [:text, :image]).merge(user_id: current_user.id)
  end

  def update_recipe_params
    params.require(:recipe).permit(:title, :category_id, :text, :image,:image_cache, :point, :difficulty_id, ingredients_attributes: [:ingredient, :quantity, :_destroy, :id], makeds_attributes: [:text, :image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def set_category_parent
    @category_parents = Category.where("ancestry is null")
  end
end

