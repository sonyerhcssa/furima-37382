class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to       :user
  belongs_to       :postage
  belongs_to       :category
  belongs_to       :item_status
  belongs_to       :prefecture
  belongs_to       :item_send
  
  has_many         :comments

  has_one          :purchase
  has_one_attached :image

  validates :item_name, :explanation,
            presence: true

  validates :image,
            presence: { message: 'を選択してください'}

  validates :category_id, :item_status_id, :postage_id, :prefecture_id, :item_send_id,
            presence: true, numericality: { other_than: 1, message: 'を選択してください' }

  validates :price,
            presence: true, inclusion: { in: 300..9_999_999, message: '¥300~¥9,999,999の半角数値で入力してください' }
end
