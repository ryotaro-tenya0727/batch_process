FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ゲームユーザー#{n}" }  # この行を追加
  end
end
