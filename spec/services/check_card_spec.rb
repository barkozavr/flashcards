require 'rails_helper'

describe CheckCard do
  let!(:user) { create :user }
  let(:deck) { create :deck, user: user }
  let!(:card) { create :card, deck: deck }
  let(:check) { CheckCard.new(card, 'transponder') }

  context 'with true answers' do
    it 'sets true_answers += 1' do
      check.call
      expect(card.true_answers).to eq 1
    end

    context 'and 1 typo' do
      let(:levenshtein_check) { CheckCard.new(card, 'tranpsonder') }
      it 'sets true_answers += 1' do
        levenshtein_check.call
        expect(card.true_answers).to eq 1
        expect(card.attempt).to eq 0
      end
    end
    it 'sets review_date + 12 hours' do
      check.call
      expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[1]).to_date)
    end

    it 'sets review_date + 3 days' do
      2.times { check.call }
      expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[2]).to_date)
    end

    it 'sets review_date + 1 week' do
      3.times { check.call }
      expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[3]).to_date)
    end

    it 'sets review_date + 2 weeks' do
      4.times { check.call }
      expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[4]).to_date)
    end

    it 'sets review_date + 1 month' do
      5.times { check.call }
      expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[5]).to_date)
    end

    context 'and one false answer' do
      let(:false_check) { CheckCard.new(card, 'false_ans') }

      before do
        2.times { check.call }
        false_check.call
      end

      it 'keeps review_date and sets attempt += 1' do
        expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[2]).to_date)
        expect(card.attempt).to eq 1
      end

      it 'resets attempt to 0 after one true answer' do
        check.call
        expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[3]).to_date)
        expect(card.attempt).to eq 0
      end
    end

    it 'sets review_date + 100 years' do
      6.times { check.call }
      expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[6]).to_date)
    end
  end

  context 'with false_answers' do
    let(:false_check) { CheckCard.new(card, 'false_answer') }
    let(:levenshtein_check) { CheckCard.new(card, 'tranpsonde') }

    it 'not updates review_date with more then 1 typo' do
      levenshtein_check.call
      expect(card.true_answers).to eq 0
      expect(card.attempt).to eq 1
      expect(card.review_date).to eq(Time.current.to_date)
    end

    it 'not updates review_date with 1 false answer and set attempt = 1' do
      false_check.call
      expect(card.review_date).to eq(Time.current.to_date)
      expect(card.attempt).to eq 1
    end

    it 'not updates review_date with 2 false answers and set attempt = 2' do
      2.times { false_check.call }
      expect(card.review_date).to eq(Time.current.to_date)
      expect(card.attempt).to eq 2
    end

    context '3 times' do
      before do
        2.times { check.call }
        3.times { false_check.call }
      end

      it 'resets review_date to Time.current + 12 hours' do
        expect(card.review_date).to eq((Time.current + CheckCard::REVIEW_PERIODS[1]).to_date)
      end

      it 'resets attempt to 0' do
        expect(card.attempt).to eq 0
      end

      it 'resets true_answers to 1' do
        expect(card.true_answers). to eq 1
      end
    end
  end
end
