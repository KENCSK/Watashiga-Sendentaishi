FactoryBot.define do
  factory :post do
    title { "テストタイトル" }
    text { "テスト本文" }
    address { "新宿区高田馬場１－１－１" }
    association :user
  end
end
