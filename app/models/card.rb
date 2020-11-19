class Card < ApplicationRecord
  validates :original_text, presence: true, length: { maximum: 50 }
  validates :translated_text, presence: true, length: { maximum: 50 }
  before_create :set_review_date
  validate :check_not_equal

  def check_not_equal
    return unless original_text && translated_text
    if original_text.casecmp(translated_text).zero?
      errors.add(:translated_text, I18n.t('card.error.equal'))
    end
  end

  private

  TIME_INTERVAL = 3

  def set_review_date
    self.review_date = DateTime.now + TIME_INTERVAL.days
  end
end
