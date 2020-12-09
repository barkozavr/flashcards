# frozen_string_literal: true

class Card < ApplicationRecord
  mount_uploader :picture, PictureUploader
  before_create :set_review_date
  belongs_to :deck
  delegate :user, to: :deck
  validates :original_text, presence: true, length: { maximum: 50 }
  validates :translated_text, presence: true, length: { maximum: 50 }
  validate :check_not_equal

  def check_not_equal
    return unless original_text && translated_text
    if original_text.casecmp(translated_text).zero?
      errors.add(:translated_text, I18n.t('card.error.equal'))
    end
  end

  scope :out_of_time, -> { where("review_date <= ?", Time.current) }

  def self.random_card
    out_of_time.order('RANDOM()').take
  end

  private

  def set_review_date
    self.review_date = Time.current
  end
end
