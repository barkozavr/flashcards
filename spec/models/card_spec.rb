require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:translated_text) }
    it { should validate_presence_of(:original_text) }
  end

  describe "callbacks tests" do
    let (:card) { create :card }
    it "ensures set_review_date before_create" do
      expect(card.review_date).to eq(Date.today + Card::TIME_INTERVAL.days)
    end
  end
end
