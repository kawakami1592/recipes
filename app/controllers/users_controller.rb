class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit]
  before_action :authenticate_user!
  
  def edit
  end

  def update
    if current_user.update(user_params) 
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
  end


  private

  def user_params
    params.require(:user).permit(:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana,:zipcode,:Prefecture_id,:city,:address,:buildingname,:phone,:birthyear_id,:birthmonth_id,:birthday_id)
    # 入力された値を受け取る
  end

  def set_user
    @user = User.find(params[:id])
  end

end
