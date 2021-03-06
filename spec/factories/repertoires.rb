FactoryBot.define do
  factory :repertoire do
    association :user

    name                      { '料理名リョウリメイりょうりめい' }
    cooking_time_id           { Faker::Number.between(from: 2, to: 10) }
    recipe                    { 'テストてすとtest' }
    comment                   { 'テストてすとtest' }
    category_id               { Faker::Number.between(from: 2, to: 6) }
    serving_id                { Faker::Number.between(from: 2, to: 6) }

    after(:build) do |repertoire|
      repertoire.image.attach(io: File.open('app/assets/images/blue.jpeg'), filename: 'blue.jpeg', content_type: 'image/png')
    end
  end
end
