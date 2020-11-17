class Card < ApplicationRecord
  validates :original_text, presence: true, length: { maximum: 50 }
  validates :translated_text, presence: true, length: { maximum: 50 }
  before_create :set_review_date

  private

  def set_review_date
    self.review_date = DateTime.now
  end
end
