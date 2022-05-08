class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :contributor_confirmation
  before_action :sold_out_confirmation

  def index
    @purchase_address = PurchaseAddress.new
  end

  def new
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_address
    params.require(:purchase_address).permit(:item_id, :post_code, :prefecture_id, :city,
                                             :address, :building, :phone_number).merge(user_id: current_user.id, item_id: set_item.id,
                                                                                       token: params[:token])
  end

  def contributor_confirmation
    redirect_to root_path if current_user.id == @item.user_id
  end

  def sold_out_confirmation
    redirect_to root_path if @item.purchase.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_address[:token],
      currency: 'jpy'
    )
  end
end
