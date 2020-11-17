FactoryBot.define do
  
  factory :card do
    original_text { "test original text" }
    translated_text { "test translated te" }
    factory :invalid_card do
      original_text { 'a'*51 }
      translated_text { 'b'*51 }
    end
  end
end
