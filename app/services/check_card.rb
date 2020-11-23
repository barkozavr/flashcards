class CheckCard
  def initialize(card)
    @card = card
  end

  def check_translation(answer)
    if answer == @card.translated_text
      @card.update!(review_date: Date.today.next_day(Card::TIME_INTERVAL))
    end
  end
end
