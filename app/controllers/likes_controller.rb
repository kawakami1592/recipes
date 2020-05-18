class LikesController < ApplicationController

  def create
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @like = Like.new(user_id: current_user.id, recipe_id: @recipe.id)
    @like.save

    @man_like_count = Like.joins(:user).where(recipe_id: params[:recipe_id]).where("users.sex_id = 1").count
    @woman_like_count = Like.joins(:user).where(recipe_id: params[:recipe_id]).where("users.sex_id = 2").count
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @like = Like.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    @like.destroy

    @man_like_count = Like.joins(:user).where(recipe_id: params[:recipe_id]).where("users.sex_id = 1").count
    @woman_like_count = Like.joins(:user).where(recipe_id: params[:recipe_id]).where("users.sex_id = 2").count
  end
end
