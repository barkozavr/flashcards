# frozen_string_literal: true

class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  validates :user_id, :name, presence: true
  validates :current, uniqueness: { scope: :user_id }, if: :current
end
