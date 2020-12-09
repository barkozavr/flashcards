# frozen_string_literal: true

require 'rails_helper'

describe RandomCardQuery do
  let!(:user) { create :user }
  let(:deck) { create :deck, user: user }
  let(:second_deck) { create :new_deck, user: user }
  let(:card) { create :card, deck: deck }
  let(:second_card) { create :card, deck: second_deck }
  before do
    card.update!(review_date: Time.current)
    second_card.update!(review_date: Time.current)
  end

  it 'returns card from current deck' do
    one_card = RandomCardQuery.new(user).call
    expect(card).to eq(one_card)
  end
end
