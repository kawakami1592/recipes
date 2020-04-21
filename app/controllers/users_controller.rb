class UsersController < ApplicationController
  before_action :authenticate_user!
  
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
  end


  private

  def user_params
    params.require(:user).permit(:email,:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana)
    # 入力された値を受け取る
  end

end
