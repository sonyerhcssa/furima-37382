class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :item_status, :postage, :prefecture, :item_send

  belongs_to       :user
  has_one          :purchase
  has_one_attached :image

  validates :item_name, :explanation, :image,
            presence: true

  validates :category_id, :item_status_id, :postage_id, :prefecture_id, :item_send_id,
            presence: true, numericality: { other_than: 1, message: "can't be blank" }

  validates :price,
            presence: true, inclusion: { in: 300..9_999_999, message: '¥300~¥9,999,999の間で入力してください' }
end