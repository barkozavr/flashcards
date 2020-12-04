# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end
end
