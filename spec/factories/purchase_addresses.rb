FactoryBot.define do
  factory :purchase_address do
    post_code { '123-4567' }
    prefecture_id { '2' }
    city { '札幌市' }
    address { '1-1' }
    building { '札幌ビル' }
    phone_number { '11122223333' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
