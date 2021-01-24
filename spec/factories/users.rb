FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'morodomi11' }
    password_confirmation { password }
    first_name            { '正輝' }
    last_name             { '諸冨' }
    kana_first_name       { 'マサキ' }
    kana_last_name        { 'モロドミ' }
    birthday              { '1992-07-25' }
  end
end
