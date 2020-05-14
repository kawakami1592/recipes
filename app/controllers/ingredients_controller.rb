class IngredientsController < ApplicationController
  def destroy
    ingredient = Ingredient.find(params[:id])
    if ingredient.present?
      if ingredient.destroy
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
