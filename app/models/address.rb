class Address < ApplicationRecord
  belongs_to  :purchase

  validates :post_code, :prefecture_id, :city, :address, :phone_number,
  presence: true
end
