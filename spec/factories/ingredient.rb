FactoryBot.define do
  factory :ingredient do
    association :repertoire, factory: :repertoire

    name               { '材料名' }
    amount             { '分量123' }
  end
end
