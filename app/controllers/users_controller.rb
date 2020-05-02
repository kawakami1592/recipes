class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit]
  
  def edit
  end

  def update
    if current_user.update(user_params) 
      redirect_to root_path, notice: "更新できました" 
    else
      render :edit, notice: "更新できませんでした"
    end
  end

  def show
    @my_recipes = Recipe.where(user_id: params[:id])
    # binding.pry
    @category_parent = Category.where("ancestry is null")
  end


  private

  def user_params
    params.require(:user).permit(:email,:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana)
    # 入力された値を受け取る
  end

  def set_user
    @user = User.find(params[:id])
  end

end
