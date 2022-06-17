FactoryBot.define do
    factory :ingredient do
      association :repertoire

      name               {"材料名"}
      amount             {"分量123"}
    end
end
