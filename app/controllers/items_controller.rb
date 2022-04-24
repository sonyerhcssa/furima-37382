class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :params_set_id, except: [:index, :new, :create]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.order('created_at desc')
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

  def show
    
  end

  def edit
   
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :explanation, :postage_id, :category_id, :item_status_id, :prefecture_id,
                                 :item_send_id, :image).merge(user_id: current_user.id)
  end

  def params_set_id
    @item = Item.find(params[:id])
  end

  def move_to_index
    binding.pry
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user_id
  end
end
