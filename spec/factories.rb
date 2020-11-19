FactoryBot.define do
  factory :card do
    original_text { "original" }
    translated_text { "translated" }
    factory :invalid_card do
      original_text { 'a'*51 }
      translated_text { 'b'*51 }
    end
  end
end
