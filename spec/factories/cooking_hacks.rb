FactoryBot.define do
  factory :cooking_hack do
    association :user
    
    title             {"Hackタイトル"}
    contents          {"時短テクニックの内容"}

    after(:build) do |cooking_hack|
      cooking_hack.hack_image.attach(io: File.open('app/assets/images/sample-hotcake.png'), filename: 'sample-hotcake.png')
    end
    
  end
end
