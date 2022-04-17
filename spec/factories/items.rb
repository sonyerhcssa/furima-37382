FactoryBot.define do
  factory :item do
    item_name       {Faker::JapaneseMedia::DragonBall.character}
    price           {Faker::Number.within(range: 300..9999999)}
    explanation     {Faker::Lorem.paragraph(sentence_count: 7)}
    postage_id      {Faker::Number.within(range: 2..3)}
    category_id     {Faker::Number.within(range: 2..3)}
    item_status_id  {Faker::Number.within(range: 2..3)}
    prefecture_id   {Faker::Number.within(range: 2..3)}
    item_send_id    {Faker::Number.within(range: 2..3)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end