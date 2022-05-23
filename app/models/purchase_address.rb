class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address,
                :building, :phone_number, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'に半角のハイフンを含んでください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true }, format: { with: /\A\d{10,11}\z/, message: 'は正しい桁数で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building,
                   phone_number: phone_number, purchase_id: purchase.id)
  end
end
