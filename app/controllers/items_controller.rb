class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items = Item.all.order(id: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :explanation, :postage_id, :category_id, :item_status_id, :prefecture_id,
                                 :item_send_id, :image).merge(user_id: current_user.id)
  end
end
