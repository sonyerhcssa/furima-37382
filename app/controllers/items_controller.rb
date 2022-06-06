class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :params_set_id, except: [:index, :new, :create, :search]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :sold_out_confirmation, only: [:edit, :update, :destroy]

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
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
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

  def search
    if params[:q]&.dig(:item_name)
      squished_keywords = params[:q][:item_name].squish
      params[:q][:item_name_cont_any] = squished_keywords.split(" ")
    end
    @q = Item.ransack(params[:q])
    @items = @q.result
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
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user_id
  end

  def sold_out_confirmation
    redirect_to root_path if @item.purchase.present?
  end
end
