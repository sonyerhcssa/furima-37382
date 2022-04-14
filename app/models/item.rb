class Item < ApplicationRecord
  belongs_to       :user
  has_one          :purchase
  has_one_attached :image

  validates :item_name, :price, :explanation, :postage_id, :category_id,
            :item_status_id, :prefecture_id, :item_send_id, :image,
            presence: true

end