# for seeds.rb
require 'open-uri'
module Seeds
  class Cards
    TIME_INTERVAL = 3
    SEEDS_URL = 'https://1000mostcommonwords.com/1000-most-common-russian-words/'

    def call
      create_user
      parsed_page
      create_cards
    end

    private

    def create_user
      @user = User.create!(email: "ex@gmail.com", password: "000000")
    end

    def parsed_page
      @page = Nokogiri::HTML(open SEEDS_URL)
    end

    def create_cards
      @page.xpath('/html/body/main/article/div[1]/div/table/tbody/tr').drop(1).each do |tr|
        Card.create!(
          original_text: tr.at('td[3]').text,
          translated_text: tr.at('td[2]').text,
          review_date: Date.today + TIME_INTERVAL,
          user_id: @user.id
      )
      end
    end
  end
end
