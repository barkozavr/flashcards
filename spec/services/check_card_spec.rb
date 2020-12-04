require 'rails_helper'

describe CheckCard do
  let!(:user) { create :user }
  let(:deck) { create :deck, user: user }
  let(:card) { create :card, deck: deck }
  before do
    card.update!(review_date: Date.today)
    @check = CheckCard.new(card)
  end

  context 'with true_answer' do
    before do
      @check.check_translation('transponder')
    end

    it 'updates review_date' do
      card.reload
      expect(card.review_date).to eq(Date.today + Card::TIME_INTERVAL.days)
    end
  end

  context 'with false_answer' do
    before do
      @check.check_translation('beleberda')
    end

    it 'not updates review_date' do
      card.reload
      expect(card.review_date).to eq(Date.today)
    end
  end
end
