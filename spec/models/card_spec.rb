require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:translated_text) }
    it { should validate_presence_of(:original_text) }
  end

  describe 'associations' do
    it { should belong_to(:deck) }
  end

  describe "callbacks tests" do
    let(:user) { create :user }
    let(:deck) { create :deck, user: user }
    let(:card) { create :card, deck: deck }
    it "ensures set_review_date before_create" do
      expect(card.review_date).to eq(Date.today + Card::TIME_INTERVAL.days)
    end
  end
end
