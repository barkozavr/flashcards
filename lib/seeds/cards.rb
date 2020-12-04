# frozen_string_literal: true

# for seeds.rb
require 'open-uri'
module Seeds
  class Cards
    SEEDS_URL = 'https://1000mostcommonwords.com/1000-most-common-russian-words/'

    def call
      create_user
      create_deck
      parsed_page
      create_cards
    end

    private

    def create_user
      unless @user = User.find_by(email: "Pavel Barkov")
        @user = User.create!(email: "example@gmail.com", password: "000000", password_confirmation: "000000")
      end
    end

    def create_deck
      unless @deck = @user.decks.first
        @deck = @user.decks.create(name: "Сгенерированная колода", current: true, user_id: @user.id)
      end
    end

    def parsed_page
      @page = Nokogiri::HTML(open SEEDS_URL)
    end

    def create_cards
      @page.xpath('/html/body/main/article/div[1]/div/table/tbody/tr').drop(1).sample(100).each do |tr|
        Card.create!(
          original_text: tr.at('td[3]').text,
          translated_text: tr.at('td[2]').text,
          deck_id: @deck.id
        )
      end
      # only for tester
      @deck.cards.sample(5).each { |card| card.update!(review_date: Date.today) }
    end
  end
end
