class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :contributor_confirmation
  before_action :sold_out_confirmation

  def index
    # クレジットカードの登録がない場合は、クレジットカードの登録画面へ遷移する
    card = Card.find_by(user_id: current_user.id)
    redirect_to new_card_path and return unless card.present?
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
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city,
                                             :address, :building, :phone_number).merge(user_id: current_user.id, item_id: set_item.id,
                                                                                       token: set_token)
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
      customer: @customer_token,
      currency: 'jpy'
    )
  end

  def set_token
      @customer_token = current_user.card.customer_token
  end

end