class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :item_status, :postage, :prefecture, :item_send

  belongs_to       :user
  has_one          :purchase
  has_one_attached :image

  validates :item_name, :price, :explanation, :image,
            presence: true

  validates :category_id, :item_status_id, :postage_id, :prefecture_id, :item_send_id,
            presence: true, numericality: { other_than: 1, message: "can't be blank" } 

end