# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "mail@mail.ru" }
    password { "123456" }
    password_confirmation { "123456" }

    trait :invalid_user do
      email { nil }
      password_confirmation { "000000" }
    end

    trait :valid_user do
      email { "new@mail.ru" }
    end
  end

  factory :deck do
    name { "my deck" }
    current { true }

    factory :new_deck do
      name { "my deck" }
      current { false }
    end

    trait :valid_deck do
      name { "my second deck" }
      current { true }
    end

    trait :valid_deck do
      name { nil }
    end
  end

  factory :card do
    original_text { 'origigami' }
    translated_text { 'transponder' }

    trait :valid_card do
      translated_text { 'other context' }
    end

    trait :invalid_card do
      original_text { 'a'*51 }
      translated_text { 'b'*51 }
    end
  end
end
