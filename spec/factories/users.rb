FactoryBot.define do
  factory :user do
    
    transient do
      person {Gimei.name}
    end

    nickname                  {Gimei.name}
    email                     {Faker::Internet.free_email}
    password                  {Faker::Internet.password(min_length: 6)}
    encrypted_password        { password }
    last_name                 {'田中'}
    first_name                {'太郎'}
    last_name_kana            {Gimei.last.katakana}
    first_name_kana           {Gimei.first.katakana}
    birth_day                 {Faker::Date.birthday}

  end
end
