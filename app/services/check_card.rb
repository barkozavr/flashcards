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
    new_attrs, result = check_card_and_build_new_attributes
    card.update!(new_attrs.merge(review_date: Time.current + REVIEW_PERIODS[true_answers]))
    result
  end

  def true_answers
    check_card_and_build_new_attributes.first[:true_answers] || 0
  end

  def check_card_and_build_new_attributes
    case levenshtein_check
    when 0
      [correct_case, :correct]
    when 1
      [correct_case, :correct_with_one_typo]
    else
      incorrect_case
    end
  end

  def correct_case
    { true_answers: card.true_answers + 1, attempt: 0 }
  end

  def incorrect_case
    if card.attempt >= 2
      [{ attempt: 0, true_answers: 1 }, :incorrect_with_reset]
    else
      [{ attempt: card.attempt + 1, true_answers: card.true_answers }, :incorrect]
    end
  end

  def attempts_left
    3 - card.attempt
  end

  def levenshtein_check
    DamerauLevenshtein.distance(answer, card.translated_text)
  end
end
