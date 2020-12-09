# frozen_string_literal: true

class CheckCard
  REVIEW_PERIODS = { 0 => 0.days,
                     1 => 12.hours,
                     2 => 3.days,
                     3 => 1.week,
                     4 => 2.weeks,
                     5 => 1.month,
                     6 => 100.years }.freeze

  attr_accessor :card, :answer

  def initialize(card, answer)
    @card = card
    @answer = answer
  end

  def call
    result = nil
    attrs =
    if answer == card.translated_text
      result = :correct
      { true_answers: card.true_answers + 1, attempt: 0 }
    elsif card.attempt >= 2
      result = :incorrect_with_reset
      { attempt: 0, true_answers: 1 }
    else
      result = :incorrect
      { attempt: card.attempt + 1, true_answers: card.true_answers }
    end
    true_answ = attrs[:true_answers] || 0
    card.update!(attrs.merge(review_date: Time.current + REVIEW_PERIODS[true_answ]))
    result
  end

  def attempts_left
    3 - card.attempt
  end
end
