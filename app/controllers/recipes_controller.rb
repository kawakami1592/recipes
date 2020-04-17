class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]

  def index
    @items = Item.includes(:user).last(3)
  end

  def show
    if @item.blank?
      redirect_to root_path, notice: "この商品はすでに削除されています"
    end
  end

  def new
    @recipe = Recip.new
    @category_parent =  Category.where("ancestry is null")
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end

  def item_update_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :price, images: [], delete_image_ids: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end

  def set_item
    @item = Item.find_by(id:params[:id])
  end

end
