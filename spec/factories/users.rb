FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '8345mm' }
    password_confirmation { password }
    first_name            { Gimei.name.first.kanji }
    last_name             { Gimei.name.last.kanji }
    kana_first_name       { Gimei.name.first.katakana }
    kana_last_name        { Gimei.name.last.katakana }
    birthday              { Faker::Date.in_date_period }
  end
end
