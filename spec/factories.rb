# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "mail@mail.ru" }
    password { "123456" }
    password_confirmation { "123456" }

    trait :invalid do
      email { nil }
      password_confirmation { "000000" }
    end

    trait :valid do
      email { "new@mail.ru" }
    end
  end

  factory :card do
    original_text { 'origigami' }
    translated_text { 'transponder' }

    trait :invalid do
      original_text { 'a'*51 }
      translated_text { 'b'*51 }
    end
  end
end
