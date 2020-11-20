# frozen_string_literal: true

require 'rails_helper'
require './lib/seeds/cards.rb'

RSpec.describe Seeds do
  describe 'get 1000 words' do
    let(:cards) { Seeds::Cards.new }

    it "creates 1000 examples of cards" do
      expect { cards.call }.to change(Card, :count).by(1000)
    end
  end
end
